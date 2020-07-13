/* eslint-env mocha */

import assert from 'assert';
import { shallow, mount } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import Feedback from '../../components/Feedback';
import * as helper from '../../utils/helper';

describe('<Feedback/>', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Feedback />);
    const button = wrapper.find('button[type="submit"]');
    const name = wrapper.find('#name');
    const comments = wrapper.find('#comments');
    const nameLabel = wrapper.find('label[htmlFor="name"]');
    const commentsLabel = wrapper.find('label[htmlFor="comments"]');

    assert(button.exists());
    assert(name.exists());
    assert(comments.exists());
    assert.strictEqual(nameLabel.text(), 'Your name:');
    assert.strictEqual(commentsLabel.text(), 'Comments:');
  });
  it('should display error flash message if name is missing', () => {
    const postStub = sinon.stub(helper, 'post').rejects({ data: { errors: { name: ["can't be blank"] } } });
    const wrapper = mount(<Feedback />);

    return wrapper.instance().handleSubmit({ preventDefault: () => {} }).then(() => {
      wrapper.update();
      assert.strictEqual(wrapper.find('FlashMessage').prop('type'), 'danger');
      assert.strictEqual(wrapper.find('FlashMessage').at(0).children().text(), "name can't be blank");
      postStub.restore();
    });
  });
  it('should display 2 error flash messages if name and comments are missing', () => {
    const postStub = sinon.stub(helper, 'post').rejects({ data: { errors: { name: ["can't be blank"], comments: ["can't be blank"] } } });
    const wrapper = mount(<Feedback />);

    return wrapper.instance().handleSubmit({ preventDefault: () => {} }).then(() => {
      wrapper.update();
      assert.strictEqual(wrapper.find('FlashMessage').length, 2);
      assert.strictEqual(wrapper.find('FlashMessage').at(0).children().text(), "name can't be blank");
      assert.strictEqual(wrapper.find('FlashMessage').at(1).children().text(), "comments can't be blank");
      assert.strictEqual(wrapper.find('FlashMessage').at(0).prop('type'), 'danger');
      assert.strictEqual(wrapper.find('FlashMessage').at(1).prop('type'), 'danger');
      postStub.restore();
    });
  });
  it('should display succecss flash message after successful submit', () => {
    const postStub = sinon.stub(helper, 'post').resolves();
    const wrapper = mount(<Feedback />);

    return wrapper.instance().handleSubmit({ preventDefault: () => {} }).then(() => {
      wrapper.update();
      assert.strictEqual(wrapper.find('FlashMessage').prop('type'), 'success');
      assert.strictEqual(wrapper.find('FlashMessage').children().text(), 'Success!');
      postStub.restore();
    });
  });
  it('inputs should be cleared after submit', () => {
    const postStub = sinon.stub(helper, 'post').resolves();
    const wrapper = mount(<Feedback />);

    wrapper.find('textarea').instance().value = 'a comment';
    wrapper.find('input').instance().value = 'a name';
    wrapper.find('textarea').simulate('change');
    wrapper.find('input').simulate('change');
    return wrapper.instance().handleSubmit({ preventDefault: () => {}, target: { name: { value: 'My Name' }, comments: { value: 'my comments' } } }).then(() => {
      assert.strictEqual(wrapper.find('textarea').instance().value, '');
      assert.strictEqual(wrapper.find('input').instance().value, '');
      postStub.restore();
    });
  });
});

