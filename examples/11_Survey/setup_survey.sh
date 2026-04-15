#!/bin/bash
# =============================================================================
# Immunexis HCP Feedback Survey - Setup Script
# =============================================================================
# Salesforce Surveys CANNOT be created programmatically (API, Apex, Metadata).
# This script opens the Survey Builder UI and prints the survey spec to follow.
#
# Usage:
#   ./setup_survey.sh [org-alias]
#   ./setup_survey.sh 260-pm
# =============================================================================

ORG_ALIAS="${1:-260-pm}"

echo "============================================================"
echo " Immunexis HCP Feedback Survey - Setup Guide"
echo "============================================================"
echo ""
echo "Target org: $ORG_ALIAS"
echo ""

# Check if survey already exists
EXISTING=$(sf data query \
  --query "SELECT Id, DeveloperName, Name, ActiveVersionId FROM Survey WHERE DeveloperName = 'immunexis_hcp_feedback'" \
  --target-org "$ORG_ALIAS" --json 2>/dev/null \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['result']['totalSize'])" 2>/dev/null)

if [ "$EXISTING" = "1" ]; then
  echo ">>> Survey 'immunexis_hcp_feedback' already exists in this org."
  sf data query \
    --query "SELECT Id, DeveloperName, Name, ActiveVersionId FROM Survey WHERE DeveloperName = 'immunexis_hcp_feedback'" \
    --target-org "$ORG_ALIAS" 2>/dev/null
  echo ""
  echo "To verify questions:"
  sf data query \
    --query "SELECT Name, QuestionType, QuestionOrder FROM SurveyQuestion WHERE SurveyVersionId IN (SELECT Id FROM SurveyVersion WHERE SurveyId IN (SELECT Id FROM Survey WHERE DeveloperName = 'immunexis_hcp_feedback')) ORDER BY QuestionOrder" \
    --target-org "$ORG_ALIAS" 2>/dev/null
  echo ""
  echo "Survey is ready. No action needed."
  exit 0
fi

echo ">>> Survey does NOT exist yet. Opening Survey Builder..."
echo ""
echo "------------------------------------------------------------"
echo " CREATE THE SURVEY WITH THESE SETTINGS:"
echo "------------------------------------------------------------"
echo ""
echo " Survey Name:          Immunexis HCP Feedback"
echo " Developer Name:       immunexis_hcp_feedback"
echo ""
echo " Q1 (Rating/Slider):"
echo "   How would you rate your overall satisfaction with the"
echo "   clinical information presented about Immunexis today?"
echo ""
echo " Q2 (Picklist):"
echo "   Based on the information provided, how likely are you"
echo "   to consider prescribing Immunexis for your immunology"
echo "   patients?"
echo "   Choices: Very Likely | Somewhat Likely | Neutral |"
echo "            Somewhat Unlikely | Very Unlikely"
echo ""
echo " Q3 (Picklist):"
echo "   Which aspect of the Immunexis clinical profile is most"
echo "   important to your treatment decisions?"
echo "   Choices: Efficacy data | Safety/side effect profile |"
echo "            Mechanism of action | Dosing convenience |"
echo "            Long-term outcomes data | Patient quality of life"
echo ""
echo " Q4 (Picklist):"
echo "   What is the biggest unmet need you see in your current"
echo "   immunology treatment approach?"
echo "   Choices: Better disease control | Fewer side effects |"
echo "            More convenient dosing | Faster onset of action |"
echo "            Better long-term remission rates |"
echo "            Improved patient adherence"
echo ""
echo " Q5 (Short Text / Free Response):"
echo "   What additional clinical data or resources about"
echo "   Immunexis would be most valuable for your practice?"
echo ""
echo " >>> IMPORTANT: Activate the survey version after saving! <<<"
echo "------------------------------------------------------------"
echo ""

# Open the Survey Builder in the org
sf org open --target-org "$ORG_ALIAS" --path "/lightning/o/Survey/new" 2>/dev/null

echo ""
echo "After creating the survey, re-run this script to verify:"
echo "  ./setup_survey.sh $ORG_ALIAS"
