/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import App from '../../components/App';
import Feedback from '../../components/Feedback';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<App />);
    assert(wrapper.contains('Tell us what you think'));
    assert(wrapper.exists(Feedback));
    const footer = wrapper.find('footer');
    assert(footer.exists(), 'footer should exist');
    assert.strictEqual(footer.text(), 'Copyright: AppFolio');
  });
});
