(() => {
  const card = document.querySelector(".identity-card");
  const orbit = card?.querySelector(".orbit");
  if (!card || !orbit) return;

  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  let progress = 0;
  let target = 0;
  let frame = 0;

  const clamp = (value) => Math.min(1, Math.max(0, value));

  const render = () => {
    frame = 0;
    progress += (target - progress) * 0.22;
    if (Math.abs(target - progress) < 0.002) progress = target;

    orbit.style.opacity = (0.93 - 0.65 * progress).toFixed(3);

    if (progress !== target) frame = requestAnimationFrame(render);
  };

  const update = () => {
    if (reducedMotion.matches) return;
    const bounds = card.getBoundingClientRect();
    const availableScroll = document.documentElement.scrollHeight - window.innerHeight;
    const fadeDistance = Math.max(1, Math.min(bounds.height * 0.75, availableScroll));
    target = clamp((18 - bounds.top) / fadeDistance);
    if (!frame) frame = requestAnimationFrame(render);
  };

  const onMotionChange = () => {
    if (!reducedMotion.matches) {
      update();
      return;
    }
    if (frame) cancelAnimationFrame(frame);
    frame = 0;
    progress = 0;
    target = 0;
    orbit.style.removeProperty("opacity");
  };

  window.addEventListener("scroll", update, { passive: true });
  window.addEventListener("resize", update);
  reducedMotion.addEventListener("change", onMotionChange);
  onMotionChange();
})();
