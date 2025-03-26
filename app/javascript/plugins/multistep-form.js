// document.addEventListener('DOMContentLoaded', function () {
//   const wizardContainer = document.getElementById('wizard-container')
//   if (!wizardContainer) return // Don't run unless wizard is present

//   // 🔽 Insert original multistep-form.js code below here:
//   //DOM elements
//   const DOMstrings = {
//     stepsBtnClass: 'multisteps-form__progress-btn',
//     stepsBtns: document.querySelectorAll(`.multisteps-form__progress-btn`),
//     stepsBar: document.querySelector('.multisteps-form__progress'),
//     stepsForm: document.querySelector('.multisteps-form__form'),
//     stepsFormTextareas: document.querySelectorAll('.multisteps-form__textarea'),
//     stepFormPanelClass: 'multisteps-form__panel',
//     stepFormPanels: document.querySelectorAll('.multisteps-form__panel'),
//     stepPrevBtnClass: 'js-btn-prev',
//     stepNextBtnClass: 'js-btn-next',
//   }

//   //remove class from a set of items
//   const removeClasses = (elemSet, className) => {
//     elemSet.forEach((elem) => {
//       elem.classList.remove(className)
//     })
//   }

//   //return exect parent node of the element
//   const findParent = (elem, parentClass) => {
//     let currentNode = elem

//     while (!currentNode.classList.contains(parentClass)) {
//       currentNode = currentNode.parentNode
//     }

//     return currentNode
//   }

//   //get active button step number
//   const getActiveStep = (elem) => {
//     return Array.from(DOMstrings.stepsBtns).indexOf(elem)
//   }

//   //set all steps before clicked (and clicked too) to active
//   const setActiveStep = (activeStepNum) => {
//     //remove active state from all the state
//     removeClasses(DOMstrings.stepsBtns, 'js-active')

//     //set picked items to active
//     DOMstrings.stepsBtns.forEach((elem, index) => {
//       if (index <= activeStepNum) {
//         elem.classList.add('js-active')
//       }
//     })
//   }

//   //get active panel
//   const getActivePanel = () => {
//     let activePanel

//     DOMstrings.stepFormPanels.forEach((elem) => {
//       if (elem.classList.contains('js-active')) {
//         activePanel = elem
//       }
//     })

//     return activePanel
//   }

//   //open active panel (and close unactive panels)
//   const setActivePanel = (activePanelNum) => {
//     //remove active class from all the panels
//     removeClasses(DOMstrings.stepFormPanels, 'js-active')

//     //show active panel
//     DOMstrings.stepFormPanels.forEach((elem, index) => {
//       if (index === activePanelNum) {
//         elem.classList.add('js-active')

//         setFormHeight(elem)
//       }
//     })
//   }

//   //set form height equal to current panel height
//   const formHeight = (activePanel) => {
//     const activePanelHeight = activePanel.offsetHeight

//     DOMstrings.stepsForm.style.height = `${activePanelHeight}px`
//   }

//   const setFormHeight = () => {
//     const activePanel = getActivePanel()

//     formHeight(activePanel)
//   }

//   //STEPS BAR CLICK FUNCTION
//   DOMstrings.stepsBar.addEventListener('click', (e) => {
//     //check if click target is a step button
//     const eventTarget = e.target

//     if (!eventTarget.classList.contains(`${DOMstrings.stepsBtnClass}`)) {
//       return
//     }

//     //get active button step number
//     const activeStep = getActiveStep(eventTarget)

//     //set all steps before clicked (and clicked too) to active
//     setActiveStep(activeStep)

//     //open active panel
//     setActivePanel(activeStep)
//   })

//   //PREV/NEXT BTNS CLICK
//   DOMstrings.stepsForm.addEventListener('click', (e) => {
//     const eventTarget = e.target

//     //check if we clicked on `PREV` or NEXT` buttons
//     if (
//       !(
//         eventTarget.classList.contains(`${DOMstrings.stepPrevBtnClass}`) ||
//         eventTarget.classList.contains(`${DOMstrings.stepNextBtnClass}`)
//       )
//     ) {
//       return
//     }

//     //find active panel
//     const activePanel = findParent(
//       eventTarget,
//       `${DOMstrings.stepFormPanelClass}`
//     )

//     let activePanelNum = Array.from(DOMstrings.stepFormPanels).indexOf(
//       activePanel
//     )

//     //set active step and active panel onclick
//     if (eventTarget.classList.contains(`${DOMstrings.stepPrevBtnClass}`)) {
//       activePanelNum--
//     } else {
//       activePanelNum++
//     }

//     setActiveStep(activePanelNum)
//     setActivePanel(activePanelNum)
//   })

//   //SETTING PROPER FORM HEIGHT ONLOAD
//   window.addEventListener('load', setFormHeight, false)

//   //SETTING PROPER FORM HEIGHT ONRESIZE
//   window.addEventListener('resize', setFormHeight, false)
//   // const stepsBtns = document.querySelectorAll('.multisteps-form__progress-btn')
//   // const stepsForms = document.querySelectorAll('.multisteps-form__panel')

//   // let activeStep = 0

//   // function setActiveStep(index) {
//   //   stepsBtns.forEach((btn) => btn.classList.remove('js-active'))
//   //   stepsForms.forEach((panel) => panel.classList.remove('js-active'))

//   //   stepsBtns[index].classList.add('js-active')
//   //   stepsForms[index].classList.add('js-active')
//   // }

//   // stepsBtns.forEach((btn, index) => {
//   //   btn.addEventListener('click', () => setActiveStep(index))
//   // })

//   // document.querySelectorAll('.js-btn-next').forEach((btn) => {
//   //   btn.addEventListener('click', () => {
//   //     if (activeStep < stepsForms.length - 1) {
//   //       activeStep++
//   //       setActiveStep(activeStep)
//   //     }
//   //   })
//   // })

//   // document.querySelectorAll('.js-btn-prev').forEach((btn) => {
//   //   btn.addEventListener('click', () => {
//   //     if (activeStep > 0) {
//   //       activeStep--
//   //       setActiveStep(activeStep)
//   //     }
//   //   })
//   // })
// })
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.multisteps-form').forEach((wizardContainer) => {
    const stepsBtns = wizardContainer.querySelectorAll(
      '.multisteps-form__progress-btn'
    )
    const stepsForm = wizardContainer.querySelector('.multisteps-form__form')
    const stepFormPanels = wizardContainer.querySelectorAll(
      '.multisteps-form__panel'
    )
    const stepPrevBtnClass = 'js-btn-prev'
    const stepNextBtnClass = 'js-btn-next'

    const removeClasses = (elemSet, className) => {
      elemSet.forEach((elem) => elem.classList.remove(className))
    }

    const getActiveStep = (elem) => {
      return Array.from(stepsBtns).indexOf(elem)
    }

    const setActiveStep = (activeStepNum) => {
      removeClasses(stepsBtns, 'js-active')
      stepsBtns.forEach((elem, index) => {
        if (index <= activeStepNum) {
          elem.classList.add('js-active')
        }
      })
    }

    const getActivePanel = () => {
      return Array.from(stepFormPanels).find((panel) =>
        panel.classList.contains('js-active')
      )
    }

    const setActivePanel = (activePanelNum) => {
      removeClasses(stepFormPanels, 'js-active')
      stepFormPanels.forEach((elem, index) => {
        if (index === activePanelNum) {
          elem.classList.add('js-active')
          setFormHeight(elem)
        }
      })
    }

    const formHeight = (activePanel) => {
      const activePanelHeight = activePanel.offsetHeight
      stepsForm.style.height = `${activePanelHeight}px`
    }

    const setFormHeight = () => {
      const activePanel = getActivePanel()
      if (activePanel) formHeight(activePanel)
    }

    // Navigation click
    wizardContainer
      .querySelector('.multisteps-form__progress')
      .addEventListener('click', (e) => {
        const eventTarget = e.target
        if (!eventTarget.classList.contains('multisteps-form__progress-btn'))
          return
        const activeStep = getActiveStep(eventTarget)
        setActiveStep(activeStep)
        setActivePanel(activeStep)
      })

    // Prev/Next click
    stepsForm.addEventListener('click', (e) => {
      const eventTarget = e.target
      if (
        !eventTarget.classList.contains(stepPrevBtnClass) &&
        !eventTarget.classList.contains(stepNextBtnClass)
      )
        return
      const activePanel = eventTarget.closest('.multisteps-form__panel')
      const activePanelNum = Array.from(stepFormPanels).indexOf(activePanel)
      const newIndex = eventTarget.classList.contains(stepPrevBtnClass)
        ? activePanelNum - 1
        : activePanelNum + 1
      setActiveStep(newIndex)
      setActivePanel(newIndex)
    })

    // Height setup
    setFormHeight()
    window.addEventListener('resize', setFormHeight, false)
  })
})
