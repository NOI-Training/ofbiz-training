// Smooth fade-in animation for body content
document.addEventListener("DOMContentLoaded", () => {
    const container = document.querySelector(".page-container");
    if (container) {
        container.style.opacity = 0;
        setTimeout(() => { container.style.transition = "opacity 0.6s"; container.style.opacity = 1; }, 100);
    }
});

// Add active navbar link highlight
const currentUrl = window.location.href;
document.querySelectorAll(".nav-link").forEach(link => {
    if (currentUrl.includes(link.getAttribute("href"))) {
        link.style.background = "#2563EB";
    }
});
// Example: Prevent submit if taskId starts with space
document.getElementById("addTaskForm").addEventListener("submit", function (e) {
    const taskId = document.querySelector("input[name='taskId']").value;

    if (taskId.startsWith(" ")) {
        alert("Task ID cannot start with a space!");
        e.preventDefault();
    }
});
