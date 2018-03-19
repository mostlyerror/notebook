import React, { Component } from 'react';
import queryString from 'query-string';
// import api from '../utils/api';
const api = require('../utils/api.js');


class Results extends Component {
  componentDidMount() {
    var players = queryString(this.props.location.search);
    console.log('players', players);

    api.battle([
      players.playerOneName,
      players.playerTwoName
    ]).then(function (results) {
      console.log(results);
    })
  }
  render() {
    return (
      <div>Results</div>
    )
  }
}

export default Results;
