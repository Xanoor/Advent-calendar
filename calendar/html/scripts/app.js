$(window).ready(function() {
    window.addEventListener('message', function(event) {
        let data = event.data;

        if (data.showMenu) {
            $('#container').fadeIn();
        } else if (data.hideAll) {
            $('#container').fadeOut();
        }

    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://calendar/escape', '{}');
        }
    };

    $('#container').hide();

    document.onclick = function() {
        if (window.event.target.id == "case") {
            $.post('http://calendar/submit', JSON.stringify({
                date: window.event.target.className
            }))
        }
    }
});