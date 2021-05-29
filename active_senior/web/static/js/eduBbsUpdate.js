
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
    localStorage.setItem("updateHireBbsTitle", $("#bbsTitle").val())
    localStorage.setItem("updateHireBbsContent", $('#summernote').summernote('code'))
    localStorage.setItem("updateHireBbsState", $("#bbsState option:selected").val())
    localStorage.setItem("updateHireBbsRecruitNum", $("#recruitmentNumber").val())
    localStorage.setItem("updateHireBbsAgency", $("#agency").val())
    localStorage.setItem("updateHireBbsDepartment", $("#department").val())
    localStorage.setItem(("updateHireBbsRecruitStart"), $("#recruitStart").val())
    localStorage.setItem(("updateHireBbsRecruitEnd"), $("#recruitEnd").val())
    localStorage.setItem(("updateHireBbsEduStart"), $("#eduStart").val())
    localStorage.setItem(("updateHireBbsEduEnd"), $("#eduEnd").val())
    localStorage.setItem(("updateHireBbsActiveStart"), $("#activeStart").val())
    localStorage.setItem(("updateHireBbsActiveEnd"), $("#activeEnd").val())
}

function getContent() {
    let getTitle = localStorage.getItem("updateHireBbsTitle")
    let getContent = localStorage.getItem("updateHireBbsContent")
    let getState = localStorage.getItem("updateHireBbsState")
    let getRecruitNum = localStorage.getItem("updateHireBbsRecruitNum")
    let getAgency = localStorage.getItem("updateHireBbsAgency")
    let getDepartment = localStorage.getItem("updateHireBbsDepartment")
    let getRecruitStart = localStorage.getItem("updateHireBbsRecruitStart")
    let getRecruitEnd = localStorage.getItem("updateHireBbsRecruitEnd")
    let getEduStart = localStorage.getItem("updateHireBbsEduStart")
    let getEduEnd = localStorage.getItem("updateHireBbsEduEnd")
    let getActiveStart = localStorage.getItem("updateHireBbsActiveStart")
    let getActiveEnd = localStorage.getItem("updateHireBbsActiveEnd")

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