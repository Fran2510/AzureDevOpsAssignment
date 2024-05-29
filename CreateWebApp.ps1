#script was run in Azure Cloud Shell

$resourceGroupName = "RG-01"
$appName = "WebAppSysKit4"
$location = "West Europe"
$appServicePlanName = "ASP-RG01-98bb"
$pricingTier = "F1"

#create web app
$appServicePlan = Get-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $appServicePlanName -ErrorAction SilentlyContinue
if (-not $appServicePlan) {
    $appServicePlan = New-AzAppServicePlan -ResourceGroupName $resourceGroupName -Location $location -Name $appServicePlanName -Tier $pricingTier -WorkerSize 0
}

New-AzWebApp -ResourceGroupName $resourceGroupName -Name $appName -Location $location -AppServicePlan $appServicePlan.Name

#apply tags
$tags = @{
    Project     = "AzureDevOpsAssignment"
    Environment = "Staging"
    Owner       = "Fran_M"
}
Set-AzResource -ResourceGroupName $resourceGroupName -ResourceName $appName -ResourceType "Microsoft.Web/sites" -Tag $tags -Force