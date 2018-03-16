import React from 'react';
import withStorage from 'components/withStorage';

class UserInfo extends React.Component {
  state = {
    username: '',
    favoriteMovie: '',
  };

  componentDidMount() {
    const username = this.props.load('username');
    const favoriteMovie = this.props.load('favoriteMovie');

    if (!username || !favoriteMovie) {
      // this will come from the parent component
      // and would be passed when we spread props {...this.props}
      this.props.reallyLongApiCall()
        .then((user) => {
          this.props.save('username', user.username) || '';
          this.props.save('favoriteMovie', user.favoriteMovie) || '';
          this.setState({
            username: user.username,
            favoriteMovie: user.favoriteMovie,
          });
        });

    }
  }

  render() {
    const { username, favoriteMovie } = this.state;

    if (!username || !favoriteMovie) {
      return <div>Loading...</div>
    }

    return (
      <div>
        My username is {username}, and I love to watch {favoriteMovie}.
      </div>
    )
  }
}
