export class TimelineElement {
  constructor(dot, line, box) {
    this.dot = dot;
    this.line = line;
    this.box = box;
  }

  hide() {
    const className = 'hide';
    this.dot.classList.add(className);
    this.line.classList.add(className);
    this.box.classList.add(className);
  }

  unhide() {
    const className = 'hide';
    this.dot.classList.remove(className);
    this.line.classList.remove(className);
    this.box.classList.remove(className);
  }

  select() {
    const className = 'vis-selected';
    this.dot.classList.add(className);
    this.line.classList.add(className);
    this.box.classList.add(className);
  }

  unselect() {
    const className = 'vis-selected';
    this.dot.classList.remove(className);
    this.line.classList.remove(className);
    this.box.classList.remove(className);
  }
}
