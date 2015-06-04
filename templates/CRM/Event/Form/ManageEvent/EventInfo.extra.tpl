{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.4                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2013                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{if $eventID}
<br/>
<div id="registration-urls-with-different-participant-role" class="crm-accordion-wrapper">
  <div class="crm-accordion-header">
    Registration URLs for Participant Roles
  </div><!-- /.crm-accordion-header -->
  <div id="Event_Invoice_Settings" class="crm-accordion-body">
    <table border="1" cellpadding="5" cellspacing="5">
      <thead></thead>
      <tbody>
        {foreach from=$allParticipantRoles key=k item=v}
        <tr>
          <td>{$v} - </td>
          <td>{crmURL a=1 fe=1 p='civicrm/event/register' q="reset=1&id=`$eventID`&participantrole="}{$k|md5}</td>
        </tr>
        {/foreach}
      </tbody>
    </table>
    <ul>
  </ul>
  </div>
</div>
{/if}
{literal}
  <script type="text/javascript">
  cj(document).ready(function() {
    cj("#registration-urls-with-different-participant-role").appendTo("#EventInfo > div.crm-event-manage-eventinfo-form-block > table > tbody > tr > td > strong");
    cj.unique( "#registration-urls-with-different-participant-role" );
  });
</script>
{/literal}

