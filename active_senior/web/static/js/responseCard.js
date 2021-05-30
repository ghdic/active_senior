$('.response-grid').imagesLoaded(function () {
    $('.response-grid').masonry({
        itemSelector: '.response-grid-item'
    });
});

TweenMax.staggerFrom(".response-grid-item", 1, {
    ease:Back.easeOut,
    opacity: 0,
    y: 100,
    delay: 0.5
}, 0.2);

(function () {
    function init() {
        var speed = 250,
            easing = mina.easeinout;

        [].slice.call(document.querySelectorAll('#response-grid > a')).forEach(function (el) {
            var s = Snap(el.querySelector('#response-grid svg')),
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