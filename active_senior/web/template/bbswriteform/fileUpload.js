(function ($) {
    $.fn.uploader = function (options) {
        var settings = $.extend(
            {
                MessageAreaText: '선택된 파일이 없습니다.',
                MessageAreaTextWithFiles: '파일 리스트:',
                DefaultErrorMessage: '파일을 열수 없습니다.',
                BadTypeErrorMessage: '지원하지 않는 파일 형식입니다.',
                acceptedFileTypes: ['pdf', 'jpg', 'gif', 'jpeg', 'bmp', 'tif', 'tiff', 'png', 'xps', 'doc', 'docx', 'fax', 'wmp', 'ico', 'txt', 'cs', 'rtf', 'xls', 'xlsx'],
            },
            options
        );

        var uploadId = 1;
        //update the messaging
        $('.file-uploader__message-area p').text(options.MessageAreaText || settings.MessageAreaText);

        //create and add the file list and the hidden input list
        // var fileList = $('<ul class="file-list"></ul>');
        // var hiddenInputs = $('<div class="hidden-inputs hidden"></div>');
        // $('.file-uploader__message-area').after(fileList);
        // $('.file-list').after(hiddenInputs);

        //when choosing a file, add the name to the list and copy the file input into the hidden inputs
        $('.file-chooser__input').on('change', function () {
            var files = document.querySelector('.file-chooser__input').files;

            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var fileName = file.name.match(/([^\\\/]+)$/)[0];

                //clear any error condition
                $('.file-chooser').removeClass('error');
                $('.error-message').remove();

                //validate the file
                var check = checkFile(fileName);
                if (check === 'valid') {
                    // move the 'real' one to hidden list
                    $('.hidden-inputs').append($('.file-chooser__input'));

                    //insert a clone after the hiddens (copy the event handlers too)
                    $('.file-chooser').append($('.file-chooser__input').clone({ withDataAndEvents: true }));

                    //add the name and a remove button to the file-list
                    $('.file-list').append(
                        '<li style="display: none;"><span class="file-list__name">' + fileName + '</span><button class="removal-button" data-uploadid="' + uploadId + '"></button></li>'
                    );
                    $('.file-list').find('li:last').show(800);

                    //removal button handler
                    $('.removal-button').on('click', function (e) {
                        e.preventDefault();

                        //remove the corresponding hidden input
                        $('.hidden-inputs input[data-uploadid="' + $(this).data('uploadid') + '"]').remove();

                        //remove the name from file-list that corresponds to the button clicked
                        $(this)
                            .parent()
                            .hide('puff')
                            .delay(10)
                            .queue(function () {
                                $(this).remove();
                            });

                        //if the list is now empty, change the text back
                        if ($('.file-list li').length === 0) {
                            $('.file-uploader__message-area').text(options.MessageAreaText || settings.MessageAreaText);
                        }
                    });

                    //so the event handler works on the new "real" one
                    $('.hidden-inputs .file-chooser__input').removeClass('file-chooser__input').attr('data-uploadId', uploadId).attr('name', 'files');

                    //update the message area
                    $('.file-uploader__message-area').text(options.MessageAreaTextWithFiles || settings.MessageAreaTextWithFiles);

                    uploadId++;
                } else {
                    //indicate that the file is not ok
                    $('.file-chooser').addClass('error');
                    var errorText = options.DefaultErrorMessage || settings.DefaultErrorMessage;

                    if (check === 'badFileName') {
                        errorText = options.BadTypeErrorMessage || settings.BadTypeErrorMessage;
                    }

                    $('.file-chooser__input').after('<p class="error-message">' + errorText + '</p>');
                }
            }
        });

        var checkFile = function (fileName) {
            var accepted = 'invalid',
                acceptedFileTypes = this.acceptedFileTypes || settings.acceptedFileTypes,
                regex;

            for (var i = 0; i < acceptedFileTypes.length; i++) {
                regex = new RegExp('\\.' + acceptedFileTypes[i] + '$', 'i');

                if (regex.test(fileName)) {
                    accepted = 'valid';
                    break;
                } else {
                    accepted = 'badFileName';
                }
            }

            return accepted;
        };
    };
})($);

//init
$(document).ready(function () {
    console.log('hi');
    $('.fileUploader').uploader({
        MessageAreaText: 'No files selected. Please select a file.',
    });
});