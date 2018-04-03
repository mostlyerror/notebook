cards = $('.card-body').map(function (i, card) {
  var title = $(card).find('.card-title').text().trim()
  var link = $(card).find('a')[0]
  var url = null
  if (link !== undefined) {
    var url = link.href;
  }
  return {
    title: title,
    url: url
  }
})
