import React from 'react';
import { shallow } from 'enzyme';

import TodoApp from './TodoApp';

describe('todo app page', () => {
  it('has a todo heading TODO list', () => {
    const wrapper = shallow(<TodoApp />);
    const header = <h2>TODO List</h2>;
    expect(wrapper.contains(header)).toEqual(true);
  })
});
