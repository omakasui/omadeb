# Place in ~/.claude/skills since all tools populate from there as well as their own sources
mkdir -p ~/.claude/skills
if [ -L ~/.claude/skills/omadeb-ai ]; then
    rm ~/.claude/skills/omadeb-ai
fi
ln -s $OMADEB_PATH/default/omadeb-ai-skill ~/.claude/skills/omadeb-ai