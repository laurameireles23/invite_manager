module CompaniesHelper
  def number_only_field(form, field, options = {})
    default_options = {
      class: "form-control",
      min: 1,
      step: 1,
      oninput: "this.value = this.value.replace(/[^0-9]/g, '')"
    }

    form.number_field field, default_options.merge(options)
  end
end
