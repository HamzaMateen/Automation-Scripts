let todoInputForm = document.getElementById("addTodo");

let addTodoBtn = document.getElementById("submitButton");
let inputBar   = document.getElementById("inputBar");

// events 
let container = document.getElementById("container");

todoInputForm.addEventListener('submit', (event) => {    
    event.preventDefault();
    
    // get the todo at this point 
    // both cases are covered
    let todoItemString = document.getElementById("inputBar").value;

    // 1. create div container, add necessary styles
    let todoContainer = document.createElement("div");
    todoContainer.classList = "rounded-lg p-1 m-4 gap-2".split();
    // 2. create two inline-block elements
    let todoItemElem = document.createElement("span");
    let deleteItemBtn = document.createElement("button");

    // 3. style them with some string
    todoItemElem.classList = "rounded-lg font-thin text-ellipsis overflow-ellipsis".split();
    todoItemElem.textContent = todoItemString;

    deleteItemBtn.classList = "bg-pink-500 text-white rounded-lg focus-within:outline-none w-28".split()
    deleteItemBtn.textContent = "DONE";

    // 4. add them to container.
    todoContainer.appendChild(deleteItemBtn);
    todoContainer.appendChild(todoItemElem);

    // 5. add container to the form.
    container.appendChild(todoContainer);
  
    // 6. reset the inputbar to emptry string 
    inputBar.value = ""

    console.log(todosList);
})

function removeTodoHandler (event) {
    console.log(event);

    alert(event);
}

container.addEventListener('click', (event) => {
    if (event.type === 'click') {
        // Check if the clicked element is a button
        if (event.target.tagName === 'BUTTON') {
            // Perform the action (e.g., delete the todo item)
            let todoItem = event.target.parentElement;
            todoItem.remove();
        }
    }
})

