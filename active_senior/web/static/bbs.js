
$('#summernote').summernote({
    placeholder: '',
    tabsize: 2,
    width: '80vw',
    height: '60vh',
    toolbar: [
    ['style', ['style']],
    ['font', ['bold', 'underline', 'clear']],
    ['color', ['color']],
    ['para', ['ul', 'ol', 'paragraph']],
    ['table', ['table']],
    ['insert', ['link', 'picture', 'video']],
    ['view', ['fullscreen', 'codeview', 'help']]
    ]
});



$(document).ready(function() {
    $('#summernote').summernote({
        lang: 'ko-KR' // default: 'en-US'
    });
});


$(window).on('beforeunload', () => {
    return '변경사항이 저장되지 않을 수 있습니다.';
})

$('#form').submit(() => {
    $(window).unbind('beforeunload');
})

function setContent() {
    localStorage.setItem("hireBbsTitle", $("#bbsTitle").val())
    localStorage.setItem("hireBbsContent", $('#summernote').summernote('code'))
    localStorage.setItem("hireBbsState", $("input[name=bbsState]:checked").val())
    localStorage.setItem("hireBbsRecruitNum", $("#recruitmentNumber").val())
    localStorage.setItem("hireBbsAgency", $("#agency").val())
    localStorage.setItem("hireBbsDepartment", $("#department").val())
    localStorage.setItem(("hireBbsRecruitStart"), $("#recruitStart").val())
    localStorage.setItem(("hireBbsRecruitEnd"), $("#recruitEnd").val())
    localStorage.setItem(("hireBbsEduStart"), $("#eduStart").val())
    localStorage.setItem(("hireBbsEduEnd"), $("#eduEnd").val())
    localStorage.setItem(("hireBbsActiveStart"), $("#activeStart").val())
    localStorage.setItem(("hireBbsActiveEnd"), $("#activeEnd").val())
}

function getContent() {
    let getTitle = localStorage.getItem("hireBbsTitle")
    let getContent = localStorage.getItem("hireBbsContent")
    let getState = localStorage.getItem("hireBbsState")
    let getRecruitNum = localStorage.getItem("hireBbsRecruitNum")
    let getAgency = localStorage.getItem("hireBbsAgency")
    let getDepartment = localStorage.getItem("hireBbsDepartment")
    let getRecruitStart = localStorage.getItem("hireBbsRecruitStart")
    let getRecruitEnd = localStorage.getItem("hireBbsRecruitEnd")
    let getEduStart = localStorage.getItem("hireBbsEduStart")
    let getEduEnd = localStorage.getItem("hireBbsEduEnd")
    let getActiveStart = localStorage.getItem("hireBbsActiveStart")
    let getActiveEnd = localStorage.getItem("hireBbsActiveEnd")

    $("#bbsTitle").val(getTitle)
    $('#summernote').summernote('code', '')
    $('#summernote').summernote('pasteHTML', getContent)
    $('input[name=bbsState][value=' + getState + ']').prop('checked', true)
    $("#recruitmentNumber").val(getRecruitNum)
    $("#agency").val(getAgency)
    $("#department").val(getDepartment)
    $("#recruitStart").val(getRecruitStart)
    $("#recruitEnd").val(getRecruitEnd)
    $("#eduStart").val(getEduStart)
    $("#eduEnd").val(getEduEnd)
    $("#activeStart").val(getActiveStart)
    $("#activeEnd").val(getActiveEnd)
}