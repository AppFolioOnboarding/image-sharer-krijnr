import React, { Component } from 'react';
import { post } from '../utils/helper';
import FlashMessage from './FlashMessage';


export default class Feedback extends Component {
  state = { errorMessages: null };

  constructor() {
    super();
    this.comments = React.createRef();
    this.name = React.createRef();
  }

  formatErrors(errors) {
    return Object.entries(errors).map(([key, messages]) => `${key} ${messages[0]}`);
  }

  handleSubmit = (e) => {
    e.preventDefault();
    const name = this.name.current.value;
    const comments = this.comments.current.value;
    return post('/api/feedbacks', { name, comments })
      .then(() => {
        this.setState({ errorMessages: [] });
        this.name.current.value = '';
        this.comments.current.value = '';
      })
      .catch(ex => this.setState({ errorMessages: this.formatErrors(ex.data.errors) }));
  }

  render() {
    let messages = null;
    if (this.state.errorMessages) {
      messages = this.state.errorMessages && this.state.errorMessages.length ?
        this.state.errorMessages.map(message => <FlashMessage key={message} type='danger'>{message}</FlashMessage>) :
        <FlashMessage type='success'>Success!</FlashMessage>;
    }
    return (
      <React.Fragment>
        {messages}
        <form onSubmit={this.handleSubmit} className="container col-md-7">
          <div className="form-group">
            <label htmlFor="name" className="w-100">Your name:<input className="form-control" type="text" id="name" ref={this.name} /></label>
          </div>
          <div className="form-group">
            <label htmlFor="comments" className="w-100">Comments:<textarea className="form-control" id="comments" ref={this.comments} /></label>
          </div>
          <button type="submit" className="btn btn-primary">Submit</button>
        </form>
      </React.Fragment>
    );
  }
}
