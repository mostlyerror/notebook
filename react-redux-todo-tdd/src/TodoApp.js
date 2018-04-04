import React from 'react';

import Navbar from './Navbar';
import AddTodo from './AddTodo';
import TodoItem from './TodoItem';

const TodoApp = () => (
  <div>
    <Navbar />
    <div className="main">
      <h2>TODO List</h2>
      <AddTodo />
      <TodoItem />
    </div>
  </div>
);

export default TodoApp;
