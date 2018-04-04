import React from 'react';
import { shallow } from 'enzyme';
import AddTodo from './AddTodo.js';

describe('AddTodo', () => {
  it('renders the form', () => {
    const wrapper = shallow(<AddTodo />);
    expect(wrapper.find('form').length).toBe(1);
  })
})
