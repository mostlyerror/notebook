import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Badge from './Badge.js';

class App extends Component {
  render() {
    return (
      <Badge 
        name='Ben Poon'
        username='mostlyerror'
        img='https://avatars1.githubusercontent.com/u/2030072?s=200&v=4'
      />
    );
  }
}

export default App;
