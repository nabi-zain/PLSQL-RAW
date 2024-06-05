create or replace package body email_report_pkg
as
 procedure send_email (p_mail_to varchar2, p_subject varchar2, p_body_ varchar2, p_body_html_ varchar2, p_file blob, v_filename_ varchar2) 
  as
    v_mimetype varchar2(30) := 'application/pdf';
    v_id number;
    
  begin
    --wwv_flow_api.set_security_group_id(apex_util.find_security_group_id('TARS'));
    v_id := APEX_MAIL.SEND(
        p_to        => p_mail_to,
        p_from      => smtp_constants_pkg.get_email_from(),
        p_subj      => p_subject,
        p_body      => p_body_,
        p_body_html => p_body_html_);              
        
    APEX_MAIL.ADD_ATTACHMENT(
        p_mail_id    => v_id,
        p_attachment => p_file,
        p_filename   => v_filename_ || '.pdf',
        p_mime_type  => v_mimetype);

    commit;
   
   --scheduled to execute every 10 minutes, but you can execute it manually for immediate e-mail sending
   wwv_flow_mail.push_queue(
   P_SMTP_HOSTNAME => smtp_constants_pkg.get_host_name(),
   P_SMTP_PORTNO => smtp_constants_pkg.get_smtpport()
   );
    
  exception
    when others then
      raise_application_error (-20001, sqlerrm);
  end;

end email_report_pkg;















create or replace package email_report_pkg
as
  procedure send_email (p_mail_to varchar2, p_subject varchar2, p_body_ varchar2, p_body_html_ varchar2, p_file blob, v_filename_ varchar2);

end email_report_pkg;
