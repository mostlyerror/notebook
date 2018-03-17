import React, { Component } from 'react';
// import PropTypes from 'prop-types';

class Popular extends Component {
    constructor (props) {
        super(props);
        this.state = {
            selectedLanguage: 'All'
        };

        // make sure the `this` invocation within event handler
        // is always bound to the component instance itself
        this.updateLanguage = this.updateLanguage.bind(this);
    }

    updateLanguage(lang) { 
        this.setState(function () {
            return {
                selectedLanguage: lang
            }
        })
    }

    render() {
        var languages = ['All', 'JavaScript', 'Ruby', 'Java', 'CSS', 'Python'];

        return (
            <ul className='languages'>
                {languages.map((lang) => {
                    return (
                        <li 
                            style={lang === this.state.selectedLanguage ? {color: '#d0021b'} : null}
                            onClick={this.updateLanguage.bind(null, lang)}
                            key={lang}>
                            {lang}
                        </li>
                    )
                })}
            </ul>
        );
    }
}

export default Popular;