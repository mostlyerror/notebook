import React, { Component } from 'react';
import PropTypes from 'prop-types';

class Avatar extends Component {
    render() {
        return (
            <img src={this.props.img}/>
        )
    }
}

class Name extends Component {
    render() {
        return (
            <h1>Name: {this.props.name}</h1>
        )
    }

}

class Username extends Component {
    render() {
        return (
            <h3>Username: {this.props.username}</h3>
        )
    }
}
class Badge extends Component {
    render() {
        return (
            <div>
                <Avatar img={this.props.img}/>
                <Name name={this.props.name}/>
                <Username username={this.props.username}/>
            </div>
        )
    }
}
Badge.propTypes = {
    img: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired,
    username: PropTypes.string.isRequired,
}
export default Badge;