<script>
import ConversationCard from './widgets/conversation/ConversationCard.vue';

/**
 * @vue/component
 * A wrapper component for ConversationCard that provides all the necessary
 * event handling and dependency injection for conversation-related actions.
 */
export default {
  components: {
    ConversationCard,
  },
  inject: [
    'selectConversation',
    'deSelectConversation',
    'assignAgent',
    'assignTeam',
    'assignLabels',
    'updateConversationStatus',
    'toggleContextMenu',
    'markAsUnread',
    'markAsRead',
    'assignPriority',
    'isConversationSelected',
    'deleteConversation',
  ],
  props: {
    /**
     * The conversation object data.
     * @type {Object}
     */
    source: {
      type: Object,
      required: true,
    },
    /**
     * The ID of the team, used for filtering.
     * @type {String|Number}
     */
    teamId: {
      type: [String, Number],
      default: 0,
    },
    /**
     * The active label, used for filtering.
     * @type {String}
     */
    label: {
      type: String,
      default: '',
    },
    /**
     * The type of conversation, used for filtering.
     * @type {String}
     */
    conversationType: {
      type: String,
      default: '',
    },
    /**
     * The ID of the folder, used for filtering.
     * @type {String|Number}
     */
    foldersId: {
      type: [String, Number],
      default: 0,
    },
    /**
     * Whether to show the assignee's name on the card.
     * @type {Boolean}
     */
    showAssignee: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<template>
  <ConversationCard
    :key="source.id"
    :active-label="label"
    :team-id="teamId"
    :folders-id="foldersId"
    :chat="source"
    :conversation-type="conversationType"
    :selected="isConversationSelected(source.id)"
    :show-assignee="showAssignee"
    enable-context-menu
    @select-conversation="selectConversation"
    @de-select-conversation="deSelectConversation"
    @assign-agent="assignAgent"
    @assign-team="assignTeam"
    @assign-label="assignLabels"
    @update-conversation-status="updateConversationStatus"
    @context-menu-toggle="toggleContextMenu"
    @mark-as-unread="markAsUnread"
    @mark-as-read="markAsRead"
    @assign-priority="assignPriority"
    @delete-conversation="deleteConversation"
  />
</template>
