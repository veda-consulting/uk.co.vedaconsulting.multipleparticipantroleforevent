<?php

require_once 'multipleparticipantroleforevent.civix.php';

/**
 * Implementation of hook_civicrm_config
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function multipleparticipantroleforevent_civicrm_config(&$config) {
  _multipleparticipantroleforevent_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function multipleparticipantroleforevent_civicrm_xmlMenu(&$files) {
  _multipleparticipantroleforevent_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_install
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function multipleparticipantroleforevent_civicrm_install() {
  return _multipleparticipantroleforevent_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function multipleparticipantroleforevent_civicrm_uninstall() {
  return _multipleparticipantroleforevent_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function multipleparticipantroleforevent_civicrm_enable() {
  return _multipleparticipantroleforevent_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function multipleparticipantroleforevent_civicrm_disable() {
  return _multipleparticipantroleforevent_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function multipleparticipantroleforevent_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _multipleparticipantroleforevent_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function multipleparticipantroleforevent_civicrm_managed(&$entities) {
  return _multipleparticipantroleforevent_civix_civicrm_managed($entities);
}

/**
 * Implementation of hook_civicrm_caseTypes
 *
 * Generate a list of case-types
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function multipleparticipantroleforevent_civicrm_caseTypes(&$caseTypes) {
  _multipleparticipantroleforevent_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implementation of hook_civicrm_alterSettingsFolders
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function multipleparticipantroleforevent_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _multipleparticipantroleforevent_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

/**
 * Function to allow multiple participant roles to register for an event
 */
function multipleparticipantroleforevent_civicrm_buildForm($formName, &$form) {
  if ($formName == 'CRM_Event_Form_Registration_Register' || $formName == 'CRM_Event_Form_Registration_Confirm' || $formName == 'CRM_Event_Form_ManageEvent_EventInfo') {


      $allParticipantRoles    = CRM_Event_PseudoConstant::participantRole();
      if ($formName == 'CRM_Event_Form_ManageEvent_EventInfo') {
        $form->assign("allParticipantRoles", $allParticipantRoles);
        $form->assign("eventID", $form->_id);
        
        //MV #9429 EventInfo.extra.tpl has been used in other extensions, so better have custom tpl
        //and inject into page-body to avoid conflicts
        $templatePath = realpath(dirname(__FILE__)."/templates");
        // dynamically insert a template block in the page
        CRM_Core_Region::instance('page-body')->add(array(
          'template' => "{$templatePath}/CRM/Event/Form/ManageEvent/MultipleParticipantRoleLinks.tpl"
        ));
      } else {
        $participantrole = '';
        $participantroleHashed = CRM_Utils_Request::retrieve('participantrole', 'String', $form);
        foreach($allParticipantRoles as $roleId => $roleName) {
          if (md5($roleId) == $participantroleHashed) {
            $participantrole = $roleId;
            break;
          }
        }
        if (!empty($participantrole)) {
          $form->_values['event']['default_role_id'] = $participantrole;
          $form->_values['event']['participant_role'] = $allParticipantRoles[$participantrole];
          //Reassign just in case variables were assigned in preproccess
          $event = $form->get_template_vars('event');
          $event['participant_role'] = $form->_values['event']['participant_role'];
          $event['default_role_id'] = $form->_values['event']['default_role_id'];
          $form->assign("event", $event);
        }
      }
   }
}
