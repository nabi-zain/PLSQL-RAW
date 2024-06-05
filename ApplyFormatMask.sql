create or replace package RESULT_PKG is

  function apply_formatmask(p_decimal_places     versioned_component.sig_figs_number%type,
                            p_value              result.value%type) return varchar2;

  function apply_formatmask(p_analysis           versioned_component.analysis%type,
                            p_value              result.value%type) return varchar2;


end RESULT_PKG;


create or replace package body RESULT_PKG is



  function apply_formatmask(p_decimal_places     versioned_component.sig_figs_number%type,
                            p_value              result.value%type) return varchar2 as
    -- Constants
    c_undefined          constant result.value%type := -1;

    -- Local Variables
    l_format_mask        varchar2(10):= '99990.';
  begin
    -- when the decimal places number is -1, the decimal places are undefined and must be returned as it is.
    if p_decimal_places = c_undefined then
      return p_value;
    else
      return ltrim(to_char(p_value, rtrim(rpad(l_format_mask,length(l_format_mask)+p_decimal_places,'0'),'.')));
    end if;
  exception
  when others then
    return trim(p_value);

  end apply_formatmask;


  function apply_formatmask(p_analysis           versioned_component.analysis%type,
                            p_value              result.value%type) return varchar2 as
    l_decimal_places     number (2);
  begin
    select vc.sig_figs_number
      into l_decimal_places
      from component_v vc
     where trim(vc.analysis)  = trim(p_analysis);

    return apply_formatmask(p_decimal_places     => l_decimal_places,
                            p_value              => p_value);
  exception
  when others then
    return trim(p_value);
  end;



begin
  -- Initialization
  null;
end RESULT_PKG;
