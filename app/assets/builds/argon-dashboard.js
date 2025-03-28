// app/javascript/argon-dashboard.js
(function() {
  var isWindows = navigator.platform.indexOf("Win") > -1 ? true : false;
  if (isWindows) {
    if (document.getElementsByClassName("main-content")[0]) {
      var mainpanel = document.querySelector(".main-content");
      var ps = new PerfectScrollbar(mainpanel);
    }
    if (document.getElementsByClassName("sidenav")[0]) {
      var sidebar = document.querySelector(".sidenav");
      var ps1 = new PerfectScrollbar(sidebar);
    }
    if (document.getElementsByClassName("navbar-collapse")[0]) {
      var fixedplugin = document.querySelector(
        ".navbar:not(.navbar-expand-lg) .navbar-collapse"
      );
      var ps2 = new PerfectScrollbar(fixedplugin);
    }
    if (document.getElementsByClassName("fixed-plugin")[0]) {
      var fixedplugin = document.querySelector(".fixed-plugin");
      var ps3 = new PerfectScrollbar(fixedplugin);
    }
  }
})();
if (document.getElementById("navbarBlur") && document.getElementById("navbarBlur").getAttribute("data-scroll") == "true") {
  navbarBlurOnScroll("navbarBlur");
}
var popoverTriggerList = [].slice.call(
  document.querySelectorAll('[data-bs-toggle="popover"]')
);
var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl);
});
var tooltipTriggerList = [].slice.call(
  document.querySelectorAll('[data-bs-toggle="tooltip"]')
);
var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl);
});
document.addEventListener("DOMContentLoaded", function() {
  var toastElList = [].slice.call(document.querySelectorAll(".toast"));
  var toastList = toastElList.map(function(toastEl) {
    return new bootstrap.Toast(toastEl);
  });
  var toastButtonList = [].slice.call(document.querySelectorAll(".toast-btn"));
  toastButtonList.map(function(toastButtonEl) {
    toastButtonEl.addEventListener("click", function() {
      var toastToTrigger = document.getElementById(toastButtonEl.dataset.target);
      if (toastToTrigger) {
        var toast = bootstrap.Toast.getInstance(toastToTrigger);
        toast.show();
      }
    });
  });
});
if (document.querySelector('[data-toggle="widget-calendar"]')) {
  calendarEl = document.querySelector('[data-toggle="widget-calendar"]');
  today = /* @__PURE__ */ new Date();
  mYear = today.getFullYear();
  weekday = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  mDay = weekday[today.getDay()];
  m = today.getMonth();
  d = today.getDate();
  document.getElementsByClassName("widget-calendar-year")[0].innerHTML = mYear;
  document.getElementsByClassName("widget-calendar-day")[0].innerHTML = mDay;
  calendar = new FullCalendar.Calendar(calendarEl, {
    contentHeight: "auto",
    initialView: "dayGridMonth",
    selectable: true,
    initialDate: "2020-12-01",
    editable: true,
    headerToolbar: false,
    events: [
      {
        title: "Call with Dave",
        start: "2020-11-18",
        end: "2020-11-18",
        className: "bg-gradient-danger"
      },
      {
        title: "Lunch meeting",
        start: "2020-11-21",
        end: "2020-11-22",
        className: "bg-gradient-warning"
      },
      {
        title: "All day conference",
        start: "2020-11-29",
        end: "2020-11-29",
        className: "bg-gradient-success"
      },
      {
        title: "Meeting with Mary",
        start: "2020-12-01",
        end: "2020-12-01",
        className: "bg-gradient-info"
      },
      {
        title: "Winter Hackaton",
        start: "2020-12-03",
        end: "2020-12-03",
        className: "bg-gradient-danger"
      },
      {
        title: "Digital event",
        start: "2020-12-07",
        end: "2020-12-09",
        className: "bg-gradient-warning"
      },
      {
        title: "Marketing event",
        start: "2020-12-10",
        end: "2020-12-10",
        className: "bg-gradient-primary"
      },
      {
        title: "Dinner with Family",
        start: "2020-12-19",
        end: "2020-12-19",
        className: "bg-gradient-danger"
      },
      {
        title: "Black Friday",
        start: "2020-12-23",
        end: "2020-12-23",
        className: "bg-gradient-info"
      },
      {
        title: "Cyber Week",
        start: "2020-12-02",
        end: "2020-12-02",
        className: "bg-gradient-warning"
      }
    ]
  });
  calendar.render();
}
var calendarEl;
var today;
var mYear;
var weekday;
var mDay;
var m;
var d;
var calendar;
function focused(el) {
  if (el.parentElement.classList.contains("input-group")) {
    el.parentElement.classList.add("focused");
  }
}
function defocused(el) {
  if (el.parentElement.classList.contains("input-group")) {
    el.parentElement.classList.remove("focused");
  }
}
function setAttributes(el, options) {
  Object.keys(options).forEach(function(attr) {
    el.setAttribute(attr, options[attr]);
  });
}
if (document.querySelectorAll(".input-group").length != 0) {
  allInputs = document.querySelectorAll("input.form-control");
  allInputs.forEach(
    (el) => setAttributes(el, {
      onfocus: "focused(this)",
      onfocusout: "defocused(this)"
    })
  );
}
var allInputs;
if (document.querySelector(".fixed-plugin")) {
  fixedPlugin = document.querySelector(".fixed-plugin");
  fixedPluginButton = document.querySelector(".fixed-plugin-button");
  fixedPluginButtonNav = document.querySelector(".fixed-plugin-button-nav");
  fixedPluginCard = document.querySelector(".fixed-plugin .card");
  fixedPluginCloseButton = document.querySelectorAll(
    ".fixed-plugin-close-button"
  );
  navbar = document.getElementById("navbarBlur");
  buttonNavbarFixed = document.getElementById("navbarFixed");
  if (fixedPluginButton) {
    fixedPluginButton.onclick = function() {
      if (!fixedPlugin.classList.contains("show")) {
        fixedPlugin.classList.add("show");
      } else {
        fixedPlugin.classList.remove("show");
      }
    };
  }
  if (fixedPluginButtonNav) {
    fixedPluginButtonNav.onclick = function() {
      if (!fixedPlugin.classList.contains("show")) {
        fixedPlugin.classList.add("show");
      } else {
        fixedPlugin.classList.remove("show");
      }
    };
  }
  fixedPluginCloseButton.forEach(function(el) {
    el.onclick = function() {
      fixedPlugin.classList.remove("show");
    };
  });
  document.querySelector("body").onclick = function(e) {
    if (e.target != fixedPluginButton && e.target != fixedPluginButtonNav && e.target.closest(".fixed-plugin .card") != fixedPluginCard) {
      fixedPlugin.classList.remove("show");
    }
  };
  if (navbar) {
    if (navbar.getAttribute("data-scroll") == "true" && buttonNavbarFixed) {
      buttonNavbarFixed.setAttribute("checked", "true");
    }
  }
}
var fixedPlugin;
var fixedPluginButton;
var fixedPluginButtonNav;
var fixedPluginCard;
var fixedPluginCloseButton;
var navbar;
var buttonNavbarFixed;
function sidebarColor(a) {
  var parent = a.parentElement.children;
  var color = a.getAttribute("data-color");
  for (var i = 0; i < parent.length; i++) {
    parent[i].classList.remove("active");
  }
  if (!a.classList.contains("active")) {
    a.classList.add("active");
  } else {
    a.classList.remove("active");
  }
  var sidebar = document.querySelector(".sidenav");
  sidebar.setAttribute("data-color", color);
  if (document.querySelector("#sidenavCard")) {
    var sidenavCard = document.querySelector("#sidenavCard");
    let sidenavCardClasses = [
      "card",
      "card-background",
      "shadow-none",
      "card-background-mask-" + color
    ];
    sidenavCard.className = "";
    sidenavCard.classList.add(...sidenavCardClasses);
    var sidenavCardIcon = document.querySelector("#sidenavCardIcon");
    let sidenavCardIconClasses = [
      "ni",
      "ni-diamond",
      "text-gradient",
      "text-lg",
      "top-0",
      "text-" + color
    ];
    sidenavCardIcon.className = "";
    sidenavCardIcon.classList.add(...sidenavCardIconClasses);
  }
}
function sidebarType(a) {
  var parent = a.parentElement.children;
  var color = a.getAttribute("data-class");
  var body2 = document.querySelector("body");
  var bodyWhite = document.querySelector("body:not(.dark-version)");
  var bodyDark = body2.classList.contains("dark-version");
  var colors = [];
  for (var i = 0; i < parent.length; i++) {
    parent[i].classList.remove("active");
    colors.push(parent[i].getAttribute("data-class"));
  }
  if (!a.classList.contains("active")) {
    a.classList.add("active");
  } else {
    a.classList.remove("active");
  }
  var sidebar = document.querySelector(".sidenav");
  for (var i = 0; i < colors.length; i++) {
    sidebar.classList.remove(colors[i]);
  }
  sidebar.classList.add(color);
  if (color == "bg-transparent" || color == "bg-white") {
    var textWhites = document.querySelectorAll(".sidenav .text-white");
    for (let i2 = 0; i2 < textWhites.length; i2++) {
      textWhites[i2].classList.remove("text-white");
      textWhites[i2].classList.add("text-dark");
    }
  } else {
    var textDarks = document.querySelectorAll(".sidenav .text-dark");
    for (let i2 = 0; i2 < textDarks.length; i2++) {
      textDarks[i2].classList.add("text-white");
      textDarks[i2].classList.remove("text-dark");
    }
  }
  if (color == "bg-transparent" && bodyDark) {
    var textDarks = document.querySelectorAll(".navbar-brand .text-dark");
    for (let i2 = 0; i2 < textDarks.length; i2++) {
      textDarks[i2].classList.add("text-white");
      textDarks[i2].classList.remove("text-dark");
    }
  }
  if ((color == "bg-transparent" || color == "bg-white") && bodyWhite) {
    var navbarBrand = document.querySelector(".navbar-brand-img");
    var navbarBrandImg = navbarBrand.src;
    if (navbarBrandImg.includes("logo-ct.png")) {
      var navbarBrandImgNew = navbarBrandImg.replace("logo-ct", "logo-ct-dark");
      navbarBrand.src = navbarBrandImgNew;
    }
  } else {
    var navbarBrand = document.querySelector(".navbar-brand-img");
    var navbarBrandImg = navbarBrand.src;
    if (navbarBrandImg.includes("logo-ct-dark.png")) {
      var navbarBrandImgNew = navbarBrandImg.replace("logo-ct-dark", "logo-ct");
      navbarBrand.src = navbarBrandImgNew;
    }
  }
  if (color == "bg-white" && bodyDark) {
    var navbarBrand = document.querySelector(".navbar-brand-img");
    var navbarBrandImg = navbarBrand.src;
    if (navbarBrandImg.includes("logo-ct.png")) {
      var navbarBrandImgNew = navbarBrandImg.replace("logo-ct", "logo-ct-dark");
      navbarBrand.src = navbarBrandImgNew;
    }
  }
}
function navbarFixed(el) {
  let classes = [
    "position-sticky",
    "blur",
    "shadow-blur",
    "mt-4",
    "left-auto",
    "top-1",
    "z-index-sticky"
  ];
  const navbar = document.getElementById("navbarBlur");
  if (!el.getAttribute("checked")) {
    navbar.classList.add(...classes);
    navbar.setAttribute("data-scroll", "true");
    navbarBlurOnScroll("navbarBlur");
    el.setAttribute("checked", "true");
  } else {
    navbar.classList.remove(...classes);
    navbar.setAttribute("data-scroll", "false");
    navbarBlurOnScroll("navbarBlur");
    el.removeAttribute("checked");
  }
}
function navbarMinimize(el) {
  var sidenavShow = document.getElementsByClassName("g-sidenav-show")[0];
  if (!el.getAttribute("checked")) {
    sidenavShow.classList.remove("g-sidenav-pinned");
    sidenavShow.classList.add("g-sidenav-hidden");
    el.setAttribute("checked", "true");
  } else {
    sidenavShow.classList.remove("g-sidenav-hidden");
    sidenavShow.classList.add("g-sidenav-pinned");
    el.removeAttribute("checked");
  }
}
function navbarBlurOnScroll(id) {
  const navbar = document.getElementById(id);
  let navbarScrollActive = navbar ? navbar.getAttribute("data-scroll") : false;
  let scrollDistance = 5;
  let classes = ["blur", "shadow-blur", "left-auto"];
  let toggleClasses = ["shadow-none"];
  if (navbarScrollActive == "true") {
    window.onscroll = debounce(function() {
      if (window.scrollY > scrollDistance) {
        blurNavbar();
      } else {
        transparentNavbar();
      }
    }, 10);
  } else {
    window.onscroll = debounce(function() {
      transparentNavbar();
    }, 10);
  }
  var isWindows = navigator.platform.indexOf("Win") > -1 ? true : false;
  if (isWindows) {
    var content = document.querySelector(".main-content");
    if (navbarScrollActive == "true") {
      content.addEventListener(
        "ps-scroll-y",
        debounce(function() {
          if (content.scrollTop > scrollDistance) {
            blurNavbar();
          } else {
            transparentNavbar();
          }
        }, 10)
      );
    } else {
      content.addEventListener(
        "ps-scroll-y",
        debounce(function() {
          transparentNavbar();
        }, 10)
      );
    }
  }
  function blurNavbar() {
    navbar.classList.add(...classes);
    navbar.classList.remove(...toggleClasses);
    toggleNavLinksColor("blur");
  }
  function transparentNavbar() {
    navbar.classList.remove(...classes);
    navbar.classList.add(...toggleClasses);
    toggleNavLinksColor("transparent");
  }
  function toggleNavLinksColor(type) {
    let navLinks = document.querySelectorAll(".navbar-main .nav-link");
    let navLinksToggler = document.querySelectorAll(
      ".navbar-main .sidenav-toggler-line"
    );
    if (type === "blur") {
      navLinks.forEach((element) => {
        element.classList.remove("text-body");
      });
      navLinksToggler.forEach((element) => {
        element.classList.add("bg-dark");
      });
    } else if (type === "transparent") {
      navLinks.forEach((element) => {
        element.classList.add("text-body");
      });
      navLinksToggler.forEach((element) => {
        element.classList.remove("bg-dark");
      });
    }
  }
}
function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}
var total = document.querySelectorAll(".nav-pills");
function initNavs() {
  total.forEach(function(item, i) {
    var moving_div = document.createElement("div");
    var li_active = item.querySelector(".nav-link.active");
    var tab = li_active.cloneNode();
    tab.innerHTML = "-";
    moving_div.classList.add("moving-tab", "position-absolute", "nav-link");
    moving_div.appendChild(tab);
    item.appendChild(moving_div);
    var list_length = item.getElementsByTagName("li").length;
    moving_div.style.padding = "0px";
    moving_div.style.transition = ".5s ease";
    let li = item.querySelector(".nav-link.active").parentElement;
    if (li) {
      let nodes = Array.from(li.closest("ul").children);
      let index = nodes.indexOf(li) + 1;
      let sum = 0;
      if (item.classList.contains("flex-column")) {
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetHeight;
        }
        moving_div.style.transform = "translate3d(0px," + sum + "px, 0px)";
        moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
        moving_div.style.height = item.querySelector(
          "li:nth-child(" + j + ")"
        ).offsetHeight;
      } else {
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetWidth;
        }
        moving_div.style.transform = "translate3d(" + sum + "px, 0px, 0px)";
        moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
      }
    }
    item.onmouseover = function(event2) {
      let target = getEventTarget(event2);
      let li2 = target.closest("li");
      if (li2) {
        let nodes = Array.from(li2.closest("ul").children);
        let index = nodes.indexOf(li2) + 1;
        item.querySelector("li:nth-child(" + index + ") .nav-link").onclick = function() {
          moving_div = item.querySelector(".moving-tab");
          let sum = 0;
          if (item.classList.contains("flex-column")) {
            for (var j2 = 1; j2 <= nodes.indexOf(li2); j2++) {
              sum += item.querySelector(
                "li:nth-child(" + j2 + ")"
              ).offsetHeight;
            }
            moving_div.style.transform = "translate3d(0px," + sum + "px, 0px)";
            moving_div.style.height = item.querySelector(
              "li:nth-child(" + j2 + ")"
            ).offsetHeight;
          } else {
            for (var j2 = 1; j2 <= nodes.indexOf(li2); j2++) {
              sum += item.querySelector("li:nth-child(" + j2 + ")").offsetWidth;
            }
            moving_div.style.transform = "translate3d(" + sum + "px, 0px, 0px)";
            moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
          }
        };
      }
    };
  });
}
setTimeout(function() {
  initNavs();
}, 100);
window.addEventListener("resize", function(event2) {
  total.forEach(function(item, i) {
    item.querySelector(".moving-tab").remove();
    var moving_div = document.createElement("div");
    var tab = item.querySelector(".nav-link.active").cloneNode();
    tab.innerHTML = "-";
    moving_div.classList.add("moving-tab", "position-absolute", "nav-link");
    moving_div.appendChild(tab);
    item.appendChild(moving_div);
    moving_div.style.padding = "0px";
    moving_div.style.transition = ".5s ease";
    let li = item.querySelector(".nav-link.active").parentElement;
    if (li) {
      let nodes = Array.from(li.closest("ul").children);
      let index = nodes.indexOf(li) + 1;
      let sum = 0;
      if (item.classList.contains("flex-column")) {
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetHeight;
        }
        moving_div.style.transform = "translate3d(0px," + sum + "px, 0px)";
        moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
        moving_div.style.height = item.querySelector(
          "li:nth-child(" + j + ")"
        ).offsetHeight;
      } else {
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetWidth;
        }
        moving_div.style.transform = "translate3d(" + sum + "px, 0px, 0px)";
        moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
      }
    }
  });
  if (window.innerWidth < 991) {
    total.forEach(function(item, i) {
      if (!item.classList.contains("flex-column")) {
        item.classList.remove("flex-row");
        item.classList.add("flex-column", "on-resize");
        let li = item.querySelector(".nav-link.active").parentElement;
        let nodes = Array.from(li.closest("ul").children);
        let index = nodes.indexOf(li) + 1;
        let sum = 0;
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetHeight;
        }
        var moving_div = document.querySelector(".moving-tab");
        moving_div.style.width = item.querySelector("li:nth-child(1)").offsetWidth + "px";
        moving_div.style.transform = "translate3d(0px," + sum + "px, 0px)";
      }
    });
  } else {
    total.forEach(function(item, i) {
      if (item.classList.contains("on-resize")) {
        item.classList.remove("flex-column", "on-resize");
        item.classList.add("flex-row");
        let li = item.querySelector(".nav-link.active").parentElement;
        let nodes = Array.from(li.closest("ul").children);
        let index = nodes.indexOf(li) + 1;
        let sum = 0;
        for (var j = 1; j <= nodes.indexOf(li); j++) {
          sum += item.querySelector("li:nth-child(" + j + ")").offsetWidth;
        }
        var moving_div = document.querySelector(".moving-tab");
        moving_div.style.transform = "translate3d(" + sum + "px, 0px, 0px)";
        moving_div.style.width = item.querySelector("li:nth-child(" + index + ")").offsetWidth + "px";
      }
    });
  }
});
if (window.innerWidth < 991) {
  total.forEach(function(item, i) {
    if (item.classList.contains("flex-row")) {
      item.classList.remove("flex-row");
      item.classList.add("flex-column", "on-resize");
    }
  });
}
function getEventTarget(e) {
  e = e || window.event;
  return e.target || e.srcElement;
}
if (document.querySelector(".sidenav-toggler")) {
  sidenavToggler = document.getElementsByClassName("sidenav-toggler")[0];
  sidenavShow = document.getElementsByClassName("g-sidenav-show")[0];
  toggleNavbarMinimize = document.getElementById("navbarMinimize");
  if (sidenavShow) {
    sidenavToggler.onclick = function() {
      if (!sidenavShow.classList.contains("g-sidenav-hidden")) {
        sidenavShow.classList.remove("g-sidenav-pinned");
        sidenavShow.classList.add("g-sidenav-hidden");
        if (toggleNavbarMinimize) {
          toggleNavbarMinimize.click();
          toggleNavbarMinimize.setAttribute("checked", "true");
        }
      } else {
        sidenavShow.classList.remove("g-sidenav-hidden");
        sidenavShow.classList.add("g-sidenav-pinned");
        if (toggleNavbarMinimize) {
          toggleNavbarMinimize.click();
          toggleNavbarMinimize.removeAttribute("checked");
        }
      }
    };
  }
}
var sidenavToggler;
var sidenavShow;
var toggleNavbarMinimize;
var iconNavbarSidenav = document.getElementById("iconNavbarSidenav");
var iconSidenav = document.getElementById("iconSidenav");
var sidenav = document.getElementById("sidenav-main");
var body = document.getElementsByTagName("body")[0];
var className = "g-sidenav-pinned";
if (iconNavbarSidenav) {
  iconNavbarSidenav.addEventListener("click", toggleSidenav);
}
if (iconSidenav) {
  iconSidenav.addEventListener("click", toggleSidenav);
}
function toggleSidenav() {
  if (body.classList.contains(className)) {
    body.classList.remove(className);
    setTimeout(function() {
      sidenav.classList.remove("bg-white");
    }, 100);
    sidenav.classList.remove("bg-transparent");
  } else {
    body.classList.add(className);
    sidenav.classList.remove("bg-transparent");
    iconSidenav.classList.remove("d-none");
  }
}
var referenceButtons = document.querySelector("[data-class]");
window.addEventListener("resize", navbarColorOnResize);
function navbarColorOnResize() {
  if (sidenav) {
    if (window.innerWidth > 1200) {
      if (referenceButtons?.classList.contains("active") && referenceButtons?.getAttribute("data-class") === "bg-transparent") {
        sidenav.classList.remove("bg-white");
      } else {
        if (!document.querySelector("body").classList.contains("dark-version")) {
          sidenav.classList.add("bg-white");
        }
      }
    } else {
      sidenav.classList.remove("bg-transparent");
    }
  }
}
window.addEventListener("resize", sidenavTypeOnResize);
window.addEventListener("load", sidenavTypeOnResize);
function sidenavTypeOnResize() {
  let elements = document.querySelectorAll('[onclick="sidebarType(this)"]');
  if (window.innerWidth < 1200) {
    elements.forEach(function(el) {
      el.classList.add("disabled");
    });
  } else {
    elements.forEach(function(el) {
      el.classList.remove("disabled");
    });
  }
}
window.onload = function() {
  var inputs = document.querySelectorAll("input");
  for (var i = 0; i < inputs.length; i++) {
    if (inputs[i].hasAttribute("value")) {
      inputs[i].parentElement.classList.add("is-filled");
    }
    inputs[i].addEventListener(
      "focus",
      function(e) {
        this.parentElement.classList.add("is-focused");
      },
      false
    );
    inputs[i].onkeyup = function(e) {
      if (this.value != "") {
        this.parentElement.classList.add("is-filled");
      } else {
        this.parentElement.classList.remove("is-filled");
      }
    };
    inputs[i].addEventListener(
      "focusout",
      function(e) {
        if (this.value != "") {
          this.parentElement.classList.add("is-filled");
        }
        this.parentElement.classList.remove("is-focused");
      },
      false
    );
  }
  var ripples = document.querySelectorAll(".btn");
  for (var i = 0; i < ripples.length; i++) {
    ripples[i].addEventListener(
      "click",
      function(e) {
        var targetEl = e.target;
        var rippleDiv = targetEl.querySelector(".ripple");
        rippleDiv = document.createElement("span");
        rippleDiv.classList.add("ripple");
        rippleDiv.style.width = rippleDiv.style.height = Math.max(targetEl.offsetWidth, targetEl.offsetHeight) + "px";
        targetEl.appendChild(rippleDiv);
        rippleDiv.style.left = e.offsetX - rippleDiv.offsetWidth / 2 + "px";
        rippleDiv.style.top = e.offsetY - rippleDiv.offsetHeight / 2 + "px";
        rippleDiv.classList.add("ripple");
        setTimeout(function() {
          rippleDiv.parentElement.removeChild(rippleDiv);
        }, 600);
      },
      false
    );
  }
};
function darkMode(el) {
  const body2 = document.getElementsByTagName("body")[0];
  const darkModeEnabled = body2.classList.contains("dark-version");
  const hr = document.querySelectorAll("div:not(.sidenav) > hr");
  const hr_card = document.querySelectorAll("div:not(.bg-gradient-dark) hr");
  const text_btn = document.querySelectorAll("button:not(.btn) > .text-dark");
  const text_span = document.querySelectorAll(
    "span.text-dark, .breadcrumb .text-dark"
  );
  const text_span_white = document.querySelectorAll(
    "span.text-white, .breadcrumb .text-white"
  );
  const text_strong = document.querySelectorAll("strong.text-dark");
  const text_strong_white = document.querySelectorAll("strong.text-white");
  const text_nav_link = document.querySelectorAll("a.nav-link.text-dark");
  const text_nav_link_white = document.querySelectorAll("a.nav-link.text-white");
  const secondary = document.querySelectorAll(".text-secondary");
  const bg_gray_100 = document.querySelectorAll(".bg-gray-100");
  const bg_gray_600 = document.querySelectorAll(".bg-gray-600");
  const btn_text_dark = document.querySelectorAll(
    ".btn.btn-link.text-dark, .material-symbols-rounded.text-dark"
  );
  const btn_text_white = document.querySelectorAll(
    ".btn.btn-link.text-white, .material-symbols-rounded.text-white"
  );
  const card_border = document.querySelectorAll(".card.border");
  const card_border_dark = document.querySelectorAll(".card.border.border-dark");
  const mainContent_blur = document.querySelectorAll(
    ".main-content .container-fluid .card"
  );
  const svg = document.querySelectorAll("g");
  const sidenavs = document.querySelectorAll(".sidenav");
  if (!el.getAttribute("checked")) {
    body2.classList.add("dark-version");
    for (var i = 0; i < hr.length; i++) {
      if (hr[i].classList.contains("dark")) {
        hr[i].classList.remove("dark");
        hr[i].classList.add("light");
      }
    }
    for (let i2 = 0; i2 < sidenavs.length; i2++) {
      const sidenav2 = sidenavs[i2];
      console.log(sidenav2);
      if (sidenav2.classList.contains("bg-white")) {
        sidenav2.classList.remove("bg-white");
        sidenav2.classList.add("bg-dark");
      }
    }
    for (var i = 0; i < mainContent_blur.length; i++) {
      if (mainContent_blur[i].classList.contains("blur")) {
        mainContent_blur[i].classList.remove("blur", "shadow-blur");
      }
    }
    for (var i = 0; i < hr_card.length; i++) {
      if (hr_card[i].classList.contains("dark")) {
        hr_card[i].classList.remove("dark");
        hr_card[i].classList.add("light");
      }
    }
    for (var i = 0; i < text_btn.length; i++) {
      if (text_btn[i].classList.contains("text-dark")) {
        text_btn[i].classList.remove("text-dark");
        text_btn[i].classList.add("text-white");
      }
    }
    for (var i = 0; i < text_span.length; i++) {
      if (text_span[i].classList.contains("text-dark")) {
        text_span[i].classList.remove("text-dark");
        text_span[i].classList.add("text-white");
      }
    }
    for (var i = 0; i < text_strong.length; i++) {
      if (text_strong[i].classList.contains("text-dark")) {
        text_strong[i].classList.remove("text-dark");
        text_strong[i].classList.add("text-white");
      }
    }
    for (var i = 0; i < text_nav_link.length; i++) {
      if (text_nav_link[i].classList.contains("text-dark")) {
        text_nav_link[i].classList.remove("text-dark");
        text_nav_link[i].classList.add("text-white");
      }
    }
    for (var i = 0; i < secondary.length; i++) {
      if (secondary[i].classList.contains("text-secondary")) {
        secondary[i].classList.remove("text-secondary");
        secondary[i].classList.add("text-white");
        secondary[i].classList.add("opacity-8");
      }
    }
    for (var i = 0; i < bg_gray_100.length; i++) {
      if (bg_gray_100[i].classList.contains("bg-gray-100")) {
        bg_gray_100[i].classList.remove("bg-gray-100");
        bg_gray_100[i].classList.add("bg-gray-600");
      }
    }
    for (var i = 0; i < btn_text_dark.length; i++) {
      btn_text_dark[i].classList.remove("text-dark");
      btn_text_dark[i].classList.add("text-white");
    }
    for (var i = 0; i < svg.length; i++) {
      if (svg[i].hasAttribute("fill")) {
        svg[i].setAttribute("fill", "#fff");
      }
    }
    for (var i = 0; i < card_border.length; i++) {
      card_border[i].classList.add("border-dark");
    }
    el.setAttribute("checked", "true");
  } else {
    body2.classList.remove("dark-version");
    for (var i = 0; i < hr.length; i++) {
      if (hr[i].classList.contains("light")) {
        hr[i].classList.add("dark");
        hr[i].classList.remove("light");
      }
    }
    for (let i2 = 0; i2 < sidenavs.length; i2++) {
      if (sidenav.classList.contains("bg-dark")) {
        sidenav.classList.remove("bg-dark");
        sidenav.classList.add("bg-white");
      }
    }
    for (var i = 0; i < hr_card.length; i++) {
      if (hr_card[i].classList.contains("light")) {
        hr_card[i].classList.add("dark");
        hr_card[i].classList.remove("light");
      }
    }
    for (var i = 0; i < mainContent_blur.length; i++) {
      mainContent_blur[i].classList.add("blur", "shadow-blur");
    }
    for (var i = 0; i < text_btn.length; i++) {
      if (text_btn[i].classList.contains("text-white")) {
        text_btn[i].classList.remove("text-white");
        text_btn[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < text_span_white.length; i++) {
      if (text_span_white[i].classList.contains("text-white") && !text_span_white[i].closest(".sidenav") && !text_span_white[i].closest(".card.bg-gradient-dark")) {
        text_span_white[i].classList.remove("text-white");
        text_span_white[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < text_strong_white.length; i++) {
      if (text_strong_white[i].classList.contains("text-white")) {
        text_strong_white[i].classList.remove("text-white");
        text_strong_white[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < text_nav_link_white.length; i++) {
      if (text_nav_link_white[i].classList.contains("text-white") && !text_nav_link_white[i].closest(".sidenav")) {
        text_nav_link_white[i].classList.remove("text-white");
        text_nav_link_white[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < secondary.length; i++) {
      if (secondary[i].classList.contains("text-white")) {
        secondary[i].classList.remove("text-white");
        secondary[i].classList.remove("opacity-8");
        secondary[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < bg_gray_600.length; i++) {
      if (bg_gray_600[i].classList.contains("bg-gray-600")) {
        bg_gray_600[i].classList.remove("bg-gray-600");
        bg_gray_600[i].classList.add("bg-gray-100");
      }
    }
    for (var i = 0; i < svg.length; i++) {
      if (svg[i].hasAttribute("fill")) {
        svg[i].setAttribute("fill", "#252f40");
      }
    }
    for (var i = 0; i < btn_text_white.length; i++) {
      if (!btn_text_white[i].closest(".card.bg-gradient-dark")) {
        btn_text_white[i].classList.remove("text-white");
        btn_text_white[i].classList.add("text-dark");
      }
    }
    for (var i = 0; i < card_border_dark.length; i++) {
      card_border_dark[i].classList.remove("border-dark");
    }
    el.removeAttribute("checked");
  }
  if (!darkModeEnabled) {
    body2.classList.add("dark-version");
    localStorage.setItem("darkMode", "enabled");
    el.setAttribute("checked", "true");
  } else {
    body2.classList.remove("dark-version");
    localStorage.setItem("darkMode", "disabled");
    el.removeAttribute("checked");
  }
}
if (document.querySelector(".datepicker")) {
  flatpickr(".datepicker", {
    mode: "range"
  });
}
var form = document.getElementById("form");
var username = document.getElementById("username");
var email = document.getElementById("email");
var password = document.getElementById("password");
var password2 = document.getElementById("confirm_password");
function showError(input, message) {
  const formControl = input.parentElement;
  formControl.className = "input-group input-group-outline my-5 is-invalid is-filled";
  const small = formControl.querySelector("small");
  small.innerText = message;
}
function showSucces(input) {
  const formControl = input.parentElement;
  formControl.className = "input-group input-group-outline my-5 is-valid is-filled";
}
function checkEmail(input) {
  const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  if (re.test(input.value.trim())) {
    showSucces(input);
  } else {
    showError(input, "Email is not invalid");
  }
}
function checkRequired(inputArr) {
  inputArr.forEach(function(input) {
    if (input.value.trim() === "") {
      showError(input, `${getFieldName(input)} is required`);
    } else {
      showSucces(input);
    }
  });
}
function checkLength(input, min, max) {
  if (input.value.length < min) {
    showError(
      input,
      `${getFieldName(input)} must be at least ${min} characters`
    );
  } else if (input.value.length > max) {
    showError(
      input,
      `${getFieldName(input)} must be les than ${max} characters`
    );
  } else {
    showSucces(input);
  }
}
function getFieldName(input) {
  return input.id.charAt(0).toUpperCase() + input.id.slice(1);
}
function checkPasswordMatch(input1, input2) {
  if (input1.value !== input2.value) {
    showError(input2, "Passwords do not match");
  }
}
if (form) {
  form.addEventListener("submit", function(e) {
    e.preventDefault();
    checkRequired([username, email, password, password2]);
    checkLength(username, 3, 15);
    checkLength(password, 6, 25);
    checkEmail(email);
    checkPasswordMatch(password, password2);
  });
}
window.darkMode = darkMode;
window.navbarFixed = navbarFixed;
window.navbarMinimize = navbarMinimize;
window.focused = focused;
window.defocused = defocused;
window.sidebarColor = sidebarColor;
window.sidebarType = sidebarType;
//# sourceMappingURL=/assets/argon-dashboard.js.map
