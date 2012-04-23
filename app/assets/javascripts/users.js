$(function () {
	$('body').on('ajax:success', 'a.toggle_admin', function (e, html) {
		$(this).replaceWith($(html));
	});
});
