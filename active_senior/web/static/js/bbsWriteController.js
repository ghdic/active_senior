
$('#summernote').summernote({
    placeholder: '',
    tabsize: 2,
    width: '80%',
    height: '800px',
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

let url_name = window.location.href.split('/').pop()

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
    if($("#bbsTitle").length)
        localStorage.setItem(url_name + "Title", $("#bbsTitle").val())
    if($('#summernote').length)
        localStorage.setItem(url_name + "Content", $('#summernote').summernote('code'))
    if($("#bbsState option:selected").length)
        localStorage.setItem(url_name + "State", $("#bbsState option:selected").val())
    if($("#recruitmentNumber").length)
        localStorage.setItem(url_name + "RecruitNum", $("#recruitmentNumber").val())
    if($("#agency").length)
        localStorage.setItem(url_name + "Agency", $("#agency").val())
    if($("#department").length)
        localStorage.setItem(url_name + "Department", $("#department").val())
    if($("#recruitStart").length)
        localStorage.setItem(url_name + "RecruitStart", $("#recruitStart").val())
    if($("#recruitEnd").length)
        localStorage.setItem(url_name + "RecruitEnd", $("#recruitEnd").val())
    if($("#eduStart").length)
        localStorage.setItem(url_name + "EduStart", $("#eduStart").val())
    if($("#eduEnd").length)
        localStorage.setItem(url_name + "EduEnd", $("#eduEnd").val())
    if($("#activeStart").length)
        localStorage.setItem(url_name + "ActiveStart", $("#activeStart").val())
    if($("#activeEnd").length)
        localStorage.setItem(url_name + "ActiveEnd", $("#activeEnd").val())
}

function getContent() {
    let getTitle = localStorage.getItem(url_name + "Title")
    let getContent = localStorage.getItem(url_name + "Content")
    let getState = localStorage.getItem(url_name + "State")
    let getRecruitNum = localStorage.getItem(url_name + "RecruitNum")
    let getAgency = localStorage.getItem(url_name + "Agency")
    let getDepartment = localStorage.getItem(url_name + "Department")
    let getRecruitStart = localStorage.getItem(url_name + "RecruitStart")
    let getRecruitEnd = localStorage.getItem(url_name + "RecruitEnd")
    let getEduStart = localStorage.getItem(url_name + "EduStart")
    let getEduEnd = localStorage.getItem(url_name + "EduEnd")
    let getActiveStart = localStorage.getItem(url_name + "ActiveStart")
    let getActiveEnd = localStorage.getItem(url_name + "ActiveEnd")
    if(getTitle)
        $("#bbsTitle").val(getTitle)
    if(getContent) {
        $('#summernote').summernote('code', '')
        $('#summernote').summernote('pasteHTML', getContent)
    }
    if(getState)
        $('#bbsState').val(getState)
    if(getRecruitNum)
        $("#recruitmentNumber").val(getRecruitNum)
    if(getAgency)
        $("#agency").val(getAgency)
    if(getDepartment)
        $("#department").val(getDepartment)
    if(getRecruitStart)
        $("#recruitStart").val(getRecruitStart)
    if(getRecruitEnd)
        $("#recruitEnd").val(getRecruitEnd)
    if(getEduStart)
        $("#eduStart").val(getEduStart)
    if(getEduEnd)
        $("#eduEnd").val(getEduEnd)
    if(getActiveStart)
        $("#activeStart").val(getActiveStart)
    if(getActiveEnd)
        $("#activeEnd").val(getActiveEnd)
}