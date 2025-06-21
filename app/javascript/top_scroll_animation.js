document.addEventListener("turbo:load", function () {
    const target = document.getElementById("scroll-buttons");
    if (!target) return;
  
    const observer = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.remove("opacity-0", "translate-y-10");
        }
      });
    }, { threshold: 0.3 });
  
    observer.observe(target);
  });