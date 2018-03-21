// const buildwithme = require('./buildwithme')
// const _ = require('lodash')
const axios = require('axios')
var db = require('./store')

function getIdeas(uri) {
  // let uri = `https://builditwith.me/api/ideas?list=all&page=${pageNum}`
  return axios.get(uri).then((response) => {
    console.log(`${response.data.ideas.length || 0} ideas found on page ${pageNum}`)
    return response.data.ideas
  })
  .catch((err) => {
    console.error(err)
  })
}

var sourceUrl = 'https://builditwith.me'
var sourceName = 'BuildWithMe'
var sourceId = 1; // change this to a database lookup of sources?

function getAllIdeas(startPage=1) {
  let uri = `https://builditwith.me/api/ideas?list=all&page=${startPage}`
  try {
    getIdeas(uri)
    .then((ideas) => {
      var formattedIdeas = ideas.map(function (item) {
        return {
          name: item.name,
          description: item.description,
          idea_type: item.idea_type,
          url: item.url,
          sourceName: sourceName,
          sourceUrl: sourceUrl,
          sourceId: sourceId,
          created_at: item.created_at,
          externalId: item.id,
        }
      })
      return formattedIdeas
    })
    .then((ideas => {
      ideas.forEach((idea) => {
        db.findOne({ sourceId: idea.sourceId, externalId: idea.externalId }, (err, doc) => {
          if (doc === null) {
            db.insert(idea)
            console.log('new doc inserted!')
          } else {
            console.log(`encountered doc with sourceId: ${idea.sourceId} and externalId: ${idea.externalId}, skipping`)
          }
        })
      })
      // console.log(`inserted ${inserted} records into the "db"`)
    }))

    getAllIdeas(startPage+1)
  }
  catch (err) {
    console.error(err)
  }
}

getAllIdeas()
