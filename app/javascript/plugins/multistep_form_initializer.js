export function initializeMultiStepForm(container) {
  if (!container) return

  const DOM = {
    stepsBtnClass: 'multisteps-form__progress-btn',
    stepsBtns: container.querySelectorAll('.multisteps-form__progress-btn'),
    stepsForm: container.querySelector('.multisteps-form__form'),
    stepFormPanels: container.querySelectorAll('.multisteps-form__panel'),
    stepPrevBtnClass: 'js-btn-prev',
    stepNextBtnClass: 'js-btn-next',
  }

  const removeClasses = (elems, className) => {
    elems.forEach((el) => el.classList.remove(className))
  }

  const findParent = (elem, parentClass) => {
    let current = elem
    while (!current.classList.contains(parentClass)) {
      current = current.parentNode
    }
    return current
  }

  const getActiveStep = (elem) => [...DOM.stepsBtns].indexOf(elem)

  const setActiveStep = (activeStep) => {
    removeClasses(DOM.stepsBtns, 'js-active')
    DOM.stepsBtns.forEach((btn, idx) => {
      if (idx <= activeStep) btn.classList.add('js-active')
    })
  }

  const setActivePanel = (activeStep) => {
    removeClasses(DOM.stepFormPanels, 'js-active')
    DOM.stepFormPanels[activeStep].classList.add('js-active')
    setFormHeight()
  }

  const setFormHeight = () => {
    const activePanel = container.querySelector(
      '.multisteps-form__panel.js-active'
    )
    if (activePanel && DOM.stepsForm) {
      DOM.stepsForm.style.height = `${activePanel.offsetHeight}px`
    }
  }

  // Add listeners
  DOM.stepsBtns.forEach((btn, idx) => {
    btn.addEventListener('click', () => {
      setActiveStep(idx)
      setActivePanel(idx)
    })
  })

  container.querySelectorAll(`.${DOM.stepNextBtnClass}`).forEach((btn) => {
    btn.addEventListener('click', () => {
      const activePanel = findParent(btn, 'multisteps-form__panel')
      let panelIndex = [...DOM.stepFormPanels].indexOf(activePanel)
      panelIndex++
      setActiveStep(panelIndex)
      setActivePanel(panelIndex)
    })
  })

  container.querySelectorAll(`.${DOM.stepPrevBtnClass}`).forEach((btn) => {
    btn.addEventListener('click', () => {
      const activePanel = findParent(btn, 'multisteps-form__panel')
      let panelIndex = [...DOM.stepFormPanels].indexOf(activePanel)
      panelIndex--
      setActiveStep(panelIndex)
      setActivePanel(panelIndex)
    })
  })

  // Initial height set
  window.addEventListener('resize', setFormHeight)
  setFormHeight()
}
