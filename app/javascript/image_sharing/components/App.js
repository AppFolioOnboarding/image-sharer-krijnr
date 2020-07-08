import React from 'react';
import Header from './Header';
import Feedback from './Feedback';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <Feedback />
      <footer className="text-center">Copyright: AppFolio</footer>
    </div>
  );
}

/* TODO: Add Prop Types check*/
