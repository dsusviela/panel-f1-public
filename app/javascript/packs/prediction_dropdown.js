const dropdownToggle = (parentId, dropdownId) => {
  $(dropdownId).toggle('fast', () => {
    if ($(dropdownId).is('visible')) {
      removeOptionsListeners(dropdownId);
    } else {
      addOptionsListeners(parentId, dropdownId);
    }
  });
};

const removeOptionsListeners = (dropdownId) => {
  $(dropdownId).off('click', 'div');
};

const addOptionsListeners = (parentId, dropdownId) => {
  $(dropdownId).on('click', 'div', (event) => {
    optionSelected(parentId, event.target);
  });
};

const optionSelected = (buttonTarget, option) => {
  $(buttonTarget).html(option.textContent);
  $(`${buttonTarget}-value`).val(option.attributes.value.nodeValue);
};

$(() => {
  $('button#circuit-dropdown-toggle').on('click', () =>
    dropdownToggle('#circuit-dropdown-toggle', '#circuit-dropdown-content')
  );
  $('button#first-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#first-driver-dropdown-toggle', '#first-driver-dropdown-content')
  );
  $('button#second-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#second-driver-dropdown-toggle', '#second-driver-dropdown-content')
  );
  $('button#third-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#third-driver-dropdown-toggle', '#third-driver-dropdown-content')
  );
  $('button#fourth-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#fourth-driver-dropdown-toggle', '#fourth-driver-dropdown-content')
  );
  $('button#fifth-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#fifth-driver-dropdown-toggle', '#fifth-driver-dropdown-content')
  );
  $('button#dnf-driver-dropdown-toggle').on('click', () =>
    dropdownToggle('#dnf-driver-dropdown-toggle', '#dnf-driver-dropdown-content')
  );
});
