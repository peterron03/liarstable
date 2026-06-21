local ScrollingFrame = script.Parent:WaitForChild("Shop")
local Buttons = ScrollingFrame:WaitForChild("TopButtons"):WaitForChild("Folder")

Buttons:WaitForChild("MedalCollab").MouseButton1Click:Connect(function()
	if ScrollingFrame.MedalCollab.Visible then
		ScrollingFrame.MedalCollab.Visible = false
		ScrollingFrame.UGC.Visible = false
		Buttons.MedalCollab:SetAttribute("Selected", false)
		Buttons.UGC:SetAttribute("Selected", false)
		Buttons.Parent.BackgroundFrame.Visible = false
	else
		ScrollingFrame.MedalCollab.Visible = true
		ScrollingFrame.UGC.Visible = false
		Buttons.MedalCollab:SetAttribute("Selected", true)
		Buttons.UGC:SetAttribute("Selected", false)
		Buttons.Parent.BackgroundFrame.Visible = true
	end
end)

Buttons:WaitForChild("UGC").MouseButton1Click:Connect(function()
	if ScrollingFrame.UGC.Visible then
		ScrollingFrame.MedalCollab.Visible = false
		ScrollingFrame.UGC.Visible = false
		Buttons.MedalCollab:SetAttribute("Selected", false)
		Buttons.UGC:SetAttribute("Selected", false)
		Buttons.Parent.BackgroundFrame.Visible = false
	else
		ScrollingFrame.MedalCollab.Visible = false
		ScrollingFrame.UGC.Visible = true
		Buttons.MedalCollab:SetAttribute("Selected", false)
		Buttons.UGC:SetAttribute("Selected", true)
		Buttons.Parent.BackgroundFrame.Visible = true
	end
end)