/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import FlashMessage from '../../components/FlashMessage';

describe('<FlashMessage />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<FlashMessage type="success">this worked</FlashMessage>);
    const flashMessage = wrapper.find('.alert');

    assert(flashMessage.exists());
    assert(flashMessage.hasClass('alert-success'));
    assert.strictEqual(flashMessage.text(), 'this worked');
  });
});
