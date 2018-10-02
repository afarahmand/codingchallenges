import React from 'react';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: ""
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user);
  }

  update(field) {
    return e => this.setState({
      [field]: e.currentTarget.value
    });
  }

  render() {
    if (this.props.currentUser !== null) {
      return (
        <div>
          <span>Access Token: {this.props.currentUser.access_token}</span>
        </div>
      );
    }

    return (
      <div>
        <img src="./logo.jpg" alt="REDACTED COMPANY logo"></img>
        <main>
          <h1>REDACTED Portal</h1>
          <form className="signin-form" onSubmit={this.handleSubmit}>

            <label htmlFor="email">Email</label>
            <input
             type="text"
             value={this.state.email}
             onChange={this.update('email')}
            />

            <label htmlFor="password">Password</label>
            <input
             type="password"
             value={this.state.password}
             onChange={this.update('password')}
            />

            <input type="submit" name="login" value="Log in"/>

          </form>
        </main>
      </div>
    );
  }
}

export default SessionForm;
