import React from 'react';
// import { Link } from 'react-router-dom';

const Navbar = ({ currentUser }) => {
  // if (currentUser === null) {
  //   return null;
  // }

  return (
    <header className="content-narrow">
      <nav>
        <ul>
          <li>
            <img src="./static/logo.svg" alt="X logo"></img>
          </li>

          <li className="text-yellow">
            <i className="far fa-plus-square"></i>
            <span>Get a Quote</span>
          </li>

          <li>
            <i className="fas fa-search-location"></i>
            Tracking
          </li>

          <li>
            <i className="fas fa-file-invoice-dollar"></i>
            Billing
          </li>

          <li>
            <i className="far fa-user"></i>
            Account
          </li>

          <li>
            <i className="far fa-life-ring"></i>
            Help
          </li>
        </ul>

      </nav>

      <div>
        {currentUser.firstName} {currentUser.lastName}
        <i className="fas fa-angle-down"></i>
      </div>
    </header>
  );
};

export default Navbar;
