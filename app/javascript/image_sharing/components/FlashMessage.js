import PropTypes from 'prop-types';
import React from 'react';

export default function FlashMessage(props) {
  return (
    <div className={`alert alert-${props.type}`}>
      {props.children}
    </div>
  );
}

FlashMessage.propTypes = {
  children: PropTypes.node.isRequired,
  type: PropTypes.oneOf(['success', 'danger']).isRequired
};
