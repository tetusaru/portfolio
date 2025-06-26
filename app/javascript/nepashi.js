document.addEventListener("turbo:load", () => {
  const img = document.getElementById("nepashi");
  if (!img) return;

  const frame1 = img.dataset.frame1;
  const frame2 = img.dataset.frame2;
  const frames = [frame1, frame2];
  let current = 0;
  let intervalId = null;

  // 既存のイベントリスナーを除去（再登録時の重複を防ぐ）
  img.onmouseenter = null;
  img.onmouseleave = null;

  img.addEventListener("mouseenter", () => {
    intervalId = setInterval(() => {
      current = (current + 1) % frames.length;
      img.src = frames[current];
    }, 250);
  });

  img.addEventListener("mouseleave", () => {
    clearInterval(intervalId);
    img.src = frame1;
  });
});