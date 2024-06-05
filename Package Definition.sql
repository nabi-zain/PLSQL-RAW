create or replace package body smtp_constants_pkg
as
  function get_smtpserver return varchar2 is
    begin
      return c_smtpserver;
    end;

  function get_smtpport return number is
    begin
      return c_smtpport;
    end;

  function get_host_name return varchar2 is
    begin
      return c_hostname;
    end;

  function get_email_from return varchar2 is
    begin
      return c_emailfrom;
    end;
end smtp_constants_pkg;










create or replace package smtp_constants_pkg as

--global constants
c_smtpserver constant varchar2(11)  := '172.18.5.18';
c_smtpport   constant number        := 25;
c_hostname   constant varchar2(11)  := '172.5.1.52';
c_emailfrom  constant varchar2(100) := 'Oracle.Admin@zain.org.za';

--get functions
function get_smtpserver return varchar2;
function get_smtpport   return number;
function get_host_name  return varchar2;
function get_email_from return varchar2;

end smtp_constants_pkg;