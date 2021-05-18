import time
import urllib.error

from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
import re
import pymysql
from datetime import datetime
import random
import os
from urllib.request import urlretrieve
import shutil


# 탭에 크롤링할 대상 리소스가 로드 될때까지 기다려준다
def waitSession(val, t):
    try:
        element = WebDriverWait(driver, t).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, val))
        )
    except TimeoutException:
        print("타임아웃")

def refresh(val, t):
    try:
        element = WebDriverWait(driver, t).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, val))
        )
    except TimeoutException:
        driver.refresh()
        refresh()


options = webdriver.ChromeOptions()
options.add_experimental_option("prefs", {
    "download.default_directory": os.path.abspath(os.curdir) + '\\' + "static\\image\\temp",
    "download.prompt_for_download": False,
    "download.directory_upgrade": True,
    "safebrowsing.enabled": True
})
driver = webdriver.Chrome('chromedriver', options=options)
main_url = "https://50plus.or.kr"

my_db = pymysql.connect(
    user='root',
    passwd='root',
    host='127.0.0.1',
    db='active_senior',
    charset='utf8mb4'
)
cursor = my_db.cursor(pymysql.cursors.DictCursor)


def reverse_list(d, k):
    k.reverse()
    new_l = []
    for i in k:
        new_l.append(d[i])
    return new_l

def random_filename(length):
    filename = ""
    for i in range(length):
        n = random.randint(0, 35)
        if n < 10:
            filename += str(n)
        else:
            filename += chr(ord('a') - 10 + n)
    return filename


def set_filename(path, ext):
    filename = ""
    while True:
        filename = random_filename(30) + '.' + ext
        filename = path + "/" + filename
        if not os.path.isfile(filename): break
    return filename


def url_path_modifier(html, path):
    pattern = re.compile('src="([^"]*)"')
    match = pattern.search(html)

    while match is not None:
        img_url = match.group(1)
        extension = img_url.split('.')[-1]
        if extension in ['png', 'jpeg', 'jpg', 'gif', 'bmp']:
            filename = set_filename(path, extension)

            if img_url[0] == '/':
                img_url = main_url + img_url
            try:
                urlretrieve(img_url, filename)
            except urllib.error.URLError:
                print("url_path_modifier error")
                print(img_url, filename)
                filename = "static/image/default" + "default-image.png"
            except Exception as e:
                print("에러다 에러 ", e)

            html = html[:match.start()] + 'src="' + filename + '"' + html[match.end():]

        match = pattern.search(html, match.start() + 1)

    return html


def edu_video():
    """ 교육+ - 교육영상 -> 교육 """
    edu_url = "https://50plus.or.kr/online-education.do"
    driver.get(edu_url)
    my_dict = {}

    while True:
        waitSession("body > div.container > div.show-more-wrapper > button", 10)
        button = driver.find_element_by_css_selector("body > div.container > div.show-more-wrapper > button")
        button.click()
        try:
            confirm = driver.switch_to.alert
            confirm.accept()
            break
        except:
            pass
    waitSession("#newDiv1 > #content > div > div > a", 10)
    main = driver.find_element_by_css_selector(
        "body > div.container > div.board-card-list.board-card-list--same-height.clearfix")
    all_contents = main.find_elements_by_css_selector("div#content > div > div.board-card")
    add_contents = main.find_elements_by_css_selector("div#res > div")
    for content in add_contents:
        all_contents += content.find_elements_by_css_selector("div#content > div > div")

    content_urls = []
    for content in all_contents:
        content_url = content.find_element_by_css_selector("a").get_attribute("href")
        content_urls.append(content_url)
        img_url = content.find_element_by_css_selector("a > div").get_attribute("style")
        try:
            summary = content.find_element_by_css_selector("div.board-card__info > p").text
        except:
            summary = ""
        bbsDate = content.find_element_by_css_selector("div.board-card__info__tags > p").text
        pattern = re.compile('background-image: url\("(.*)"\)')
        m = pattern.search(img_url)
        thumbnail_image_url = main_url + m.group(1)
        filename = set_filename("static/image/edu_bbs/thumbnail", thumbnail_image_url.split('.')[-1])
        urlretrieve(thumbnail_image_url, filename)
        my_dict[content_url] = {'thumbnail': thumbnail_image_url.split('/')[-1], 'summary': summary, 'bbsDate': bbsDate }

    for content_url in content_urls:
        driver.get(content_url)
        refresh("body > div.container > h2", 10)
        time.sleep(2)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "static/image/edu_bbs/content")
        tags = driver.find_elements_by_css_selector("body > div.container > div.show-tags")
        tag = tags[0].text.replace("태그:", "").strip()
        keyword = tags[1].text.replace("연관키워드:", "").strip()
        my_dict[content_url]['title'] = title
        my_dict[content_url]['content'] = content
        my_dict[content_url]['tag'] = tag
        my_dict[content_url]['keyword'] = keyword
        my_dict[content_url]['userID'] = 'admin'
        my_dict[content_url]['userName'] = '관리자'
        my_dict[content_url]['bbsCategory'] = 0
    my_dict = reverse_list(my_dict, content_urls)
    import pickle
    with open('my_dict.bin', "wb") as f:
        pickle.dump(my_dict, f)
    sql = 'insert into edu_bbs (userID, userName, bbsDate, bbsTitle, bbsContent, tag, keyword, summary, bbsThumbnail, bbsCategory) values (%(userID)s, %(userName)s, %(bbsDate)s, %(title)s, %(content)s, %(tag)s, %(keyword)s, %(summary)s, %(thumbnail)s, %(bbsCategory)s)'
    cursor.executemany(sql, my_dict)
    my_db.commit()


edu_video()

def lecture():
    """ 교육+ - 교육후기 -> 교육 """
    lecture_url = "https://50plus.or.kr/lecture.do"
    all_contents_url = []
    page = 1
    while True:
        driver.get(lecture_url + "?page=" + str(page))
        waitSession(
            "body > div.container > div.board-card-list.board-card-list--same-height.clearfix > div:nth-child(1) > div > a > div",
            10)
        main = driver.find_element_by_css_selector(
            "body > div.container > div.board-card-list.board-card-list--same-height.clearfix")
        board_cards = main.find_elements_by_css_selector("div > div.board-card")
        for board_card in board_cards:
            campus = board_card.find_element_by_css_selector("label").text
            content_url = board_card.find_element_by_css_selector("a").get_attribute("href")
            image_url = board_card.find_element_by_css_selector("a > div").get_attribute("style")
            pattern = re.compile('background-image: url\("(.*)"\)')
            m = pattern.search(image_url)
            image_url = main_url + m.group(1)
            all_contents_url.append(content_url)
            print(campus)
            print(content_url)
            print(image_url)
        if len(board_cards) == 0:
            break
        page += 1

    for content_url in all_contents_url:
        driver.get(content_url)
        driver.implicitly_wait(3)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "edu_bbs/content")
        tag = driver.find_element_by_css_selector("body > div.container > div:nth-child(5)").text.replace("연관키워드: ", "")
        print(title)
        print(content)
        print(tag)


def app():
    """ 일+ - 사회공헌일자리 -> 구인 & 고용 """
    job_url = "https://50plus.or.kr/appList.do"
    page = 1
    all_job_urls = []
    my_dict = {}
    while True:
        driver.get(job_url + "?pageIndex=" + str(page))
        waitSession("body > div.container > section > div.pt-jb-cs-list > a > p > img", 10)
        job_list = driver.find_element_by_css_selector("body > div.container > section > div.pt-jb-cs-list")
        job_list = job_list.find_elements_by_css_selector("a")
        for job in job_list:
            url = job.get_attribute("href")
            thumbnail_image_url = job.find_element_by_css_selector("p > img").get_attribute("src")
            filename = set_filename("static/image/hire_bbs/thumbnail", "png")
            urlretrieve(thumbnail_image_url, filename)
            my_dict[url] = {"thumbnail": filename.split('/')[-1]}
            all_job_urls.append(url)
        if len(job_list) == 0:
            break
        page += 1

    for url in all_job_urls:
        driver.get(url)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > section > div.pt-jb-con").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "static/image/hire_bbs/content")
        summary = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(3) > td").text  # 한줄 요약
        recruit_num = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(4) > td.last").text.replace('명','')  # 모집인원
        agency = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(5) > td:nth-child(2)").text  # 담당기관
        department = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(5) > td.last").text  # 담당부서
        recruit_start, recruit_end = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(6) > td.last").text.split(
            "~")  # 모집기간
        edu_start, edu_end = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(7) > td:nth-child(2)").text.split(
            "~")  # 교육기간
        active_start, active_end = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(7) > td.last").text.split(
            "~")  # 활동기간
        state = driver.find_element_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(8) > td").text  # 공고상태

        files = driver.find_elements_by_css_selector(
            "body > div.container > section > div.tb-wrap > table > tbody > tr:nth-child(9) > td > div > a")
        my_dict[url]['title'] = title
        my_dict[url]['content'] = content
        my_dict[url]['summary'] = summary
        my_dict[url]['recruitNum'] = recruit_num
        my_dict[url]['agency'] = agency
        my_dict[url]['department'] = department
        my_dict[url]['recruitStart'] = recruit_start
        my_dict[url]['recruitEnd'] = recruit_end
        my_dict[url]['eduStart'] = edu_start
        my_dict[url]['eduEnd'] = edu_end
        my_dict[url]['activeStart'] = active_start
        my_dict[url]['activeEnd'] = active_end
        my_dict[url]['state'] = state

        real_file_name = []
        original_file_name = []
        for file in files:
            file_name = file.get_attribute("onclick")
            pattern = re.compile("fn_fileDown\('([^']*)', '([^']*)'\)")
            m = pattern.search(file_name)
            # file_url = main_url + m.group(1)
            file_name = m.group(2)
            if file_name == '':
                continue
            original_file_name.append(file_name)
            filename = set_filename("static/image/hire_bbs/upload", file_name.split('.')[-1])
            file_name = "static/image/temp/" + file_name
            file.click()
            while True:
                if os.path.isfile(file_name): break
                time.sleep(1)
            shutil.move(file_name, filename)
            real_file_name.append(filename.split('/')[-1])
        my_dict[url]['realFileName'] = ','.join(real_file_name)
        my_dict[url]['originalFileName'] = ','.join(original_file_name)
        my_dict[url]["userID"] = 'admin'
        my_dict[url]['userName'] = '관리자'
    my_dict = reverse_list(my_dict, all_job_urls)
    sql = 'insert into hire_bbs (userID, userName, bbsDate, bbsTitle, bbsContent, bbsThumbnail, bbsState, recruitNum, agency, department, recruitStart, recruitEnd, eduStart, eduEnd, activeStart, activeEnd, realFileName, originalFileName) values (%(userID)s, %(userName)s, %(recruitStart)s, %(title)s, %(content)s, %(thumbnail)s, %(state)s, %(recruitNum)s, %(agency)s, %(department)s, %(recruitStart)s, %(recruitEnd)s, %(eduStart)s, %(eduEnd)s, %(activeStart)s, %(activeEnd)s, %(realFileName)s, %(originalFileName)s)'
    cursor.executemany(sql, my_dict)
    my_db.commit()




def notice():
    """ 정보+ - 공지/채용정보 -> 정보알리미 """
    notice_url = "https://50plus.or.kr/notice_recruit.do"
    page = 1
    all_notice_urls = []
    while True:
        driver.get(notice_url + "?page=" + str(page))
        waitSession(
            "body > div.container > div.board-box-list.board-box-list--only-text.clearfix > div:nth-child(1) > div > div > a",
            10)
        notice_list = driver.find_element_by_css_selector(
            "body > div.container > div.board-box-list.board-box-list--only-text.clearfix")
        notice_list = driver.find_elements_by_css_selector("div.board-box-wrapper > div.board-box")
        for notice in notice_list:
            date = notice.find_element_by_css_selector("div > p").text
            url = notice.find_element_by_css_selector("div > a").get_attribute("href")
            all_notice_urls.append(url)
        if len(notice_list) == 0:
            break
        page += 1

    for notice in all_notice_urls:
        driver.get(notice)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "info_bbs/content")
        attach_files = ""

        files = driver.find_elements_by_css_selector(
            "body > div.container > div.attach-files > ul.attach-files-ul > li > a")
        for file in files:
            file_name = file.get_attribute("onclick")
            print(file_name)
            pattern = re.compile('fn_fileDown\("([^"]*)", "([^"]*)"\)')
            m = pattern.search(file_name)
            file_url = main_url + m.group(1)
            file_name = m.group(2)
            print(file_url, file_name)

        tags = driver.find_elements_by_css_selector("body > div.container > div.show-tags")
        tag = tags[0].text.replace("태그:", "").strip()
        keyword = tags[1].text.replace("연관키워드:", "").strip()

        print(title)
        print(tag)
        # print(content)
        print(keyword)


def support():
    """ 정보+ - 지원사업 -> 정보알리미 """
    support_url = "https://50plus.or.kr/support.do?page="
    page = 1
    all_support_url = []
    while True:
        driver.get(support_url + str(page))
        waitSession(
            "body > div.container > div.board-box-list.board-box-list--image-text.clearfix > div:nth-child(1) > div > a",
            10)
        support_list = driver.find_element_by_css_selector(
            "body > div.container > div.board-box-list.board-box-list--image-text.clearfix")
        support_list = support_list.find_elements_by_css_selector("div.board-box-wrapper > div.board-box > a")
        for support in support_list:
            url = support.get_attribute("href")
            thumbnail_image_url = support.find_element_by_css_selector("div > div").get_attribute("style")
            pattern = re.compile('background-image: url\("([^"]*)"\)')
            m = pattern.search(thumbnail_image_url)
            thumbnail_image_url = main_url + m.group(1)
            all_support_url.append(url)
            print(url)
            print(thumbnail_image_url)
        if len(support_list) != 0:
            break
        page += 1

    for url in all_support_url:
        driver.get(url)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "info_bbs")
        files = driver.find_elements_by_css_selector(
            "body > div.container > div.attach-files > ul.attach-files-ul > li > a")

        for file in files:
            file_name = file.get_attribute("onclick")
            print(file_name)
            pattern = re.compile('fn_fileDown\("([^"]*)", "([^"]*)"\)')
            m = pattern.search(file_name)
            file_url = main_url + m.group(1)
            file_name = m.group(2)
            print(file_url, file_name)

        tags = driver.find_elements_by_css_selector("body > div.container > div.show-tags")
        tag = tags[0].text.replace("태그:", "").strip()
        keyword = tags[1].text.replace("연관키워드:", "").strip()
        print(title)
        # print(content)
        print(tag)
        print(keyword)


def event():
    """ 정보+ - 행사소식 -> 정보알리미 """
    support_url = "https://50plus.or.kr/event.do?page="
    page = 1
    all_support_url = []
    while True:
        driver.get(support_url + str(page))
        waitSession(
            "body > div.container > div.board-box-list.board-box-list--image-text.clearfix > div:nth-child(1) > div > a",
            10)
        support_list = driver.find_element_by_css_selector(
            "body > div.container > div.board-box-list.board-box-list--image-text.clearfix")
        support_list = support_list.find_elements_by_css_selector("div.board-box-wrapper > div.board-box > a")
        for support in support_list:
            url = support.get_attribute("href")
            thumbnail_image_url = support.find_element_by_css_selector("div > div").get_attribute("style")
            pattern = re.compile('background-image: url\("([^"]*)"\)')
            m = pattern.search(thumbnail_image_url)
            thumbnail_image_url = main_url + m.group(1)
            all_support_url.append(url)
            print(url)
            print(thumbnail_image_url)
        if len(support_list) != 0:
            break
        page += 1

    for url in all_support_url:
        driver.get(url)
        title = driver.find_element_by_css_selector("body > div.container > h2").text
        content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
            "innerHTML")
        content = url_path_modifier(content, "info_bbs")
        files = driver.find_elements_by_css_selector(
            "body > div.container > div.attach-files > ul.attach-files-ul > li > a")

        for file in files:
            file_name = file.get_attribute("onclick")
            print(file_name)
            pattern = re.compile('fn_fileDown\("([^"]*)", "([^"]*)"\)')
            m = pattern.search(file_name)
            file_url = main_url + m.group(1)
            file_name = m.group(2)
            print(file_url, file_name)

        tags = driver.find_elements_by_css_selector("body > div.container > div.show-tags")
        tag = tags[0].text.replace("태그:", "").strip()
        keyword = tags[1].text.replace("연관키워드:", "").strip()
        print(title)
        # print(content)
        print(tag)
        print(keyword)


def megazine():
    """ 매거진+ - * -> 취미공유"""
    magazine_url = {'사람책': 'https://50plus.or.kr/humanbook.do?page=', '여행': 'https://50plus.or.kr/travel.do?page=',
                    '건강': 'https://50plus.or.kr/health.do?page=', '재무': 'https://50plus.or.kr/finance.do?page=',
                    '문화라이프': 'https://50plus.or.kr/culturelife.do?page='}
    for key in magazine_url.keys():
        page = 1
        all_megazine_url = []
        while True:
            driver.get(magazine_url[key] + str(page))
            waitSession(
                "body > div.container > div.board-card-list.board-card-list--custom-height.clearfix > div:nth-child(1) > div > a > div > img",
                10)
            megazine_list = driver.find_element_by_css_selector(
                "body > div.container > div.board-card-list.board-card-list--custom-height.clearfix")
            megazine_list = megazine_list.find_elements_by_css_selector("div.board-card-wrapper > div.board-card > a")
            for mega in megazine_list:
                url = mega.get_attribute("href")
                thumbnail_image_url = mega.find_element_by_css_selector("div > img").get_attribute("src")

                all_megazine_url.append(url)
                print(url)
                print(thumbnail_image_url)
            if len(megazine_list) != 0:
                break
            page += 1

        for url in all_megazine_url:
            driver.get(url)
            title = driver.find_element_by_css_selector("body > div.container > h2").text
            content = driver.find_element_by_css_selector("body > div.container > div.post-content").get_attribute(
                "innerHTML")
            content = url_path_modifier(content, "hobby_bbs")
            tags = driver.find_elements_by_css_selector("body > div.container > div.show-tags")
            tag = tags[0].text.replace("태그:", "").strip()
            keyword = tags[1].text.replace("연관키워드:", "").strip()
            print(title)
            # print(content)
            print(tag)
            print(keyword)


def community():
    """ -> 커뮤니티"""
    page = 1
    cm_url = "https://www.ddanzi.com/index.php?mid=free&page="
    all_bbs_url = []
    while True:
        driver.get(cm_url + str(page))
        bbs_list = driver.find_element_by_css_selector("#list_style > table > tbody:nth-child(3)")
        bbs_list = bbs_list.find_elements_by_css_selector("tr:not(.notice) > td.title > a:nth-child(1)")
        for bbs_url in bbs_list:
            all_bbs_url.append(bbs_url.get_attribute("href"))
        if page == 2:
            break
        page += 1

    for url in all_bbs_url:
        driver.get(url)
        title = driver.find_element_by_css_selector(
            "#board_display > div.boardR > div.read_header > div.top_title > h1 > a.link").text
        date = driver.find_element_by_css_selector(
            "#board_display > div.boardR > div.read_header > div.top_title > div > p").text
        pattern = re.compile('[0-9]{2}:[0-9]{2}:[0-9]{2}')
        if pattern.match(date):
            date = datetime.now().strftime("%Y-%m-%d")
        nickname = driver.find_element_by_css_selector("#board_display > div.boardR > div.read_header > div.meta > a")
        view = driver.find_element_by_css_selector(
            "#board_display > div.boardR > div.read_header > div.meta > span > span.read > em")
        recommend = driver.find_element_by_css_selector(
            "#board_display > div.boardR > div.read_header > div.meta > span > span.voteWrap > span.vote > em")
        content = driver.find_element_by_css_selector(
            "#board_display > div.boardR > div:nth-child(2) > div").get_attribute("innerHTML")
        content = url_path_modifier(content, "cmnty_bbs/content")
        comments = driver.find_elements_by_css_selector("#cmt_list > ul > li")
        for comment in comments:
            cm_nickname = comment.find_element_by_css_selector("div.fbItem > div.fbItem_left > div > h4 > a").text
            cm_date = comment.find_element_by_css_selector(
                "#comment_681625985 > div.fbItem > div.fbItem_left > div > p").text
            if pattern.match(date):
                cm_date = datetime.now().strftime("%Y-%m-%d") + " " + cm_date
            cm_msg = comment.find_element_by_css_selector("div.fbItem > div.fbItem_right > div > div").text


def mysql():
    my_db = pymysql.connect(
        user='root',
        passwd='root',
        host='127.0.0.1',
        db='python',
        charset='utf8'
    )
    cursor = my_db.cursor(pymysql.cursors.DictCursor)
    sql = "select * from user"
    cursor.execute(sql)
    result = cursor.fetchall()  # fetchone 하나행, fetchmany(n) n개행

    import pandas as pd
    result = pd.DataFrame(result)
    print(result)
    index = result.index[-1]
    sql = f"insert into user values('test{index + 1}', 'test', 'testname', '남자', 'test@test.com', 'sample_profile.png', 1);"
    cursor.execute(sql)
    my_db.commit()

    # # 데이터 입력. list 형 데이터
    # insert_data = [['raul', 10], ['zidane', 7], ['ronaldo', 9]]
    # insert_sql = "INSERT INTO `people` VALUES (%s, %s);"
    # cursor.executemany(insert_sql, insert_data)
    # db.commit()
    # # 데이터 입력. dict 형 데이터
    # insert_data2 = [{'name': 'holland', 'age': 9}, {'name': 'lee', 'age': 7}, {'name': 'messi', 'age': 7}]
    # insert_sql2 = "INSERT INTO `people` VALUES (%(name)s, %(age)s);"
    # cursor.executemany(insert_sql2, insert_data2)
    # db.commit()

# megazine()
# event()
# mysql()
