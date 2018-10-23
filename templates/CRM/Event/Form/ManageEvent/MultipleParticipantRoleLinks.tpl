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
{if $eventID && $isForm}
<br/>
<div id="registration-urls-with-different-participant-role" class="crm-accordion-wrapper">
  <div class="crm-accordion-header">
    Registration URLs based on Participant Roles
  </div><!-- /.crm-accordion-header -->
  <div id="Event_Invoice_Settings" class="crm-accordion-body">
    <table border="1" cellpadding="5" cellspacing="5" id="mapping">
      <thead></thead>
      <tbody>
        {foreach from=$allParticipantRoles key=k item=v}
        <tr>
          <td>{$v} - </td>
          <td class="tooltip" title="Click on url to copy!">{crmURL a=1 fe=1 p='civicrm/event/register' q="reset=1&id=`$eventID`&participantrole="}{$k|md5}</td>
        </tr>
        {/foreach}
      </tbody>
    </table>
    <ul>
  </ul>
  </div>
</div>
{literal}
  <style type="text/css">
    .ui-tooltip {
      padding: 3px 5px;
      color: #32414F;
      border-radius: 20px;
      font-size: 12px;
      box-shadow: 0 0 7px black;
    }
  </style>
  <script type="text/javascript">
  /** Function to select the text on click**/
  function selectCellText(e) {
    e = e || window.event;
    var obj = e.target || e.srcElement;
    if ( obj.nodeName.toLowerCase() === 'td' ) {
      if (document.selection) {
        var range = document.body.createTextRange();
        range.moveToElementText(obj);
        range.select();
      }
      else if (window.getSelection) {
        var range = document.createRange();
        range.selectNode(obj.firstChild);
        window.getSelection().addRange(range);
      }
    }
  }
  function init() {
    document.getElementById('mapping').onclick = selectCellText;
  }

  cj(document).ready(function() {
    init();
    cj("#mapping > tbody > tr > td.tooltip").tooltip();
    cj("#mapping > tbody > tr > td.tooltip").click(function() {
      cj(".ui-tooltip-content").parents('div').remove();
    });
    cj("#registration-urls-with-different-participant-role").appendTo("#EventInfo > div.crm-event-manage-eventinfo-form-block > table > tbody > tr > td > strong");
    //MV #8072, Using unique returns TypeError on Event contfiguration page.
    // cj.unique( "#registration-urls-with-different-participant-role" );
    //use of unique is to remove all duplciates (if any), to achieve this using nextall and remove instead of unique.
    cj("#registration-urls-with-different-participant-role").nextAll().remove();
  });
</script>
{/literal}
{/if}
