$('.grid').imagesLoaded(function () {
    $('.grid').masonry({
        itemSelector: '.grid-item'
    });
});

(function () {
    function init() {
        var speed = 250,
            easing = mina.easeinout;

        [].slice.call(document.querySelectorAll('#grid > a')).forEach(function (el) {
            var s = Snap(el.querySelector('#grid svg')),
                path = s.select('path'),
                pathConfig = {
                    from: path.attr('d'),
                    to: el.getAttribute('data-path-hover'),
                };

            el.addEventListener('mouseenter', function () {
                path.animate({ path: pathConfig.to }, speed, easing);
            });

            el.addEventListener('mouseleave', function () {
                path.animate({ path: pathConfig.from }, speed, easing);
            });
        });
    }

    init();
})();