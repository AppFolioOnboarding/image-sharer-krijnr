/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import Feedback from '../../components/Feedback';

describe('<Feedback/>', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Feedback />);
    const button = wrapper.find('button');
    assert(button.exists());
    const name = wrapper.find('input');
    assert(name.exists());
    const comments = wrapper.find('textarea');
    assert(comments.exists());
    const nameLabels = wrapper.find('label');
    assert.strictEqual(nameLabels.length, 2);
    assert.strictEqual(nameLabels.at(0).text(), 'Your name:');
    assert.strictEqual(nameLabels.at(1).text(), 'Comments:');
  });
});
