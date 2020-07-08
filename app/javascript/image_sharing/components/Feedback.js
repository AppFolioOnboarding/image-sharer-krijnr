import React from 'react';

export default function Feedback() {
  return (
    <form className="container col-md-7">
      <div className="form-group">
        <label htmlFor="name" className="w-100">Your name:<input className="form-control" type="text" id="name" /></label>
      </div>
      <div className="form-group">
        <label htmlFor="comments" className="w-100">Comments:<textarea className="form-control" id="comments" /></label>
      </div>
      <button type="submit" className="btn btn-primary">Submit</button>
    </form>
  );
}
