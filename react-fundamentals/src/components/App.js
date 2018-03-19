import React, { Component } from 'react';
// import logo from '../logo.svg';
import '../App.css';
import Popular from './Popular.js';
import Results from './Results.js';

class App extends Component {
  render() {
    return (
      <div className='container'>
        <Popular />
        <Results />
      </div>
    );
  }
}

// module.exports = App;
export default App;
