$(function() {
  return $("body > .topbar").scrollSpy();
});
$(function() {
  return $(".tabs").tabs();
});
$(function() {
  return $("a[rel=twipsy]").twipsy({
    live: true
  });
});
$(function() {
  return $("a[rel=popover]").popover({
    offset: 10
  });
});
$(function() {
  return $(".topbar-wrapper").dropdown();
});
$(function() {
  return $(".alert-message").alert();
});
$(function() {
  var domModal;
  domModal = $(".modal").modal({
    backdrop: true,
           closeOnEscape: true
  });
  return $(".open-modal").click(function() {
    return domModal.toggle();
  });
});
