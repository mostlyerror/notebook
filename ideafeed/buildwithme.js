// const axios = require('axios')
const BASE_URL = 'https://buildwith.me/ideas'
// const request = require('request-promise');
const axios = require('axios')

module.exports.getIdeas = function getIdeas(page=1) {
  // var headers = {
  //   // 'DNT': '1',
  //   // 'Accept-Encoding': 'gzip, deflate, br',
  //   // 'Accept-Language': 'en-US,en;q=0.9',
  //   // 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36',
  //   // 'Accept': '*/*',
  //   // 'Referer': 'https://builditwith.me/ideas?list=all',
  //   // 'X-Requested-With': 'XMLHttpRequest',
  //   // 'Connection': 'keep-alive',
  //   // 'Cookie': 'user=18050; hash=%24EB%23vZzDAR%264%25Q3aX07uKPwVchFt; version=7; PHPSESSID=dbq66m369uonrjuraquevdjt07; _ga=GA1.2.281137593.1521513696; _gid=GA1.2.384765292.1521513696; _gat=1'
  // };
  //
  // var options = {
  //   url: 'https://builditwith.me/api/ideas?list=all&time=1521597697879' + `&page={page}`,
  //   headers: headers
  // };
  //
  // function callback(error, response, body) {
  //   if (!error && response.statusCode == 200) {
  //     return response
  //   }
  // }
  // request.get(options)
  // .on('response', function(response) {
  //   console.log(response.statusCode)
  //   return response
  // })
  //
  // return request(options, callback);
  return axios.get('https://builditwith.me/api/ideas?list=all' + `&page={page}`)
}
