
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

window.onbeforeunload = function (e) {
    localStorage.setItem("writeHireBbsContentAuto", $('#summernote').summernote('code'))
};

window.onload = (e) => {
    let getValue = localStorage.getItem("writeHireBbsContentAuto")

    if(getValue !== null && getValue !== "" && getValue !== "<p><br></p>" && confirm("이전에 작성했던 글이 있습니다. 불러오시겠습니까?")){
        $('#summernote').summernote('code', '')
        $('#summernote').summernote('pasteHTML', getValue)
    }
}

function setContent() {
    localStorage.setItem("writeHireBbsTitle", $("#bbsTitle").val())
    localStorage.setItem("writeHireBbsContent", $('#summernote').summernote('code'))
    localStorage.setItem("writeHireBbsState", $("#bbsState option:selected").val())
    localStorage.setItem("writeHireBbsRecruitNum", $("#recruitmentNumber").val())
    localStorage.setItem("writeHireBbsAgency", $("#agency").val())
    localStorage.setItem("writeHireBbsDepartment", $("#department").val())
    localStorage.setItem(("writeHireBbsRecruitStart"), $("#recruitStart").val())
    localStorage.setItem(("writeHireBbsRecruitEnd"), $("#recruitEnd").val())
    localStorage.setItem(("writeHireBbsEduStart"), $("#eduStart").val())
    localStorage.setItem(("writeHireBbsEduEnd"), $("#eduEnd").val())
    localStorage.setItem(("writeHireBbsActiveStart"), $("#activeStart").val())
    localStorage.setItem(("writeHireBbsActiveEnd"), $("#activeEnd").val())
}

function getContent() {
    let getTitle = localStorage.getItem("writeHireBbsTitle")
    let getContent = localStorage.getItem("writeHireBbsContent")
    let getState = localStorage.getItem("writeHireBbsState")
    let getRecruitNum = localStorage.getItem("writeHireBbsRecruitNum")
    let getAgency = localStorage.getItem("writeHireBbsAgency")
    let getDepartment = localStorage.getItem("writeHireBbsDepartment")
    let getRecruitStart = localStorage.getItem("writeHireBbsRecruitStart")
    let getRecruitEnd = localStorage.getItem("writeHireBbsRecruitEnd")
    let getEduStart = localStorage.getItem("writeHireBbsEduStart")
    let getEduEnd = localStorage.getItem("writeHireBbsEduEnd")
    let getActiveStart = localStorage.getItem("writeHireBbsActiveStart")
    let getActiveEnd = localStorage.getItem("writeHireBbsActiveEnd")

    $("#bbsTitle").val(getTitle)
    $('#summernote').summernote('code', '')
    $('#summernote').summernote('pasteHTML', getContent)
    $('#bbsState').val(getState)
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