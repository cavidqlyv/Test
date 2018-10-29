<?php
/* @var $this SiteController */
/* @var $model LoginForm */
/* @var $form CActiveForm  */

$title = Yii::t('nav', 'Login');
$this->pageTitle = Yii::app()->name . ' - ' . $title;
//$this->breadcrumbs=array(
//	$title,
//);
?>
<hr class="hr-separator">
<h1><?php echo $title; ?></h1>
<?php if (Yii::app()->user->hasFlash('passwordchanged')): ?>

  <div class="flash-success">
    <?php echo Yii::app()->user->getFlash('passwordchanged'); ?>
  </div>

<?php endif; ?>

<div class="form">
  <?php
  $form = $this->beginWidget('CActiveForm', array(
      'id' => 'login-form',
      'enableClientValidation' => true,
      'clientOptions' => array(
          'validateOnSubmit' => true,
      ),
  ));
  ?>

  <div class="row">
    <?php echo $form->labelEx($model, 'username'); ?>
    <?php echo $form->textField($model, 'username'); ?>
    <?php echo $form->error($model, 'username'); ?>
  </div>

  <div class="row">
    <?php echo $form->labelEx($model, 'password'); ?>
    <?php echo $form->passwordField($model, 'password'); ?>
    <?php echo $form->error($model, 'password'); ?>
    <p class="hint">
      <?php echo CHtml::link(Yii::t('app', 'LoginForm.password.forgotten'), array('user/resetpassword')); ?>
    </p>
  </div>

  <div class="row rememberMe">
    <?php echo $form->checkBox($model, 'rememberMe'); ?>
    <?php echo $form->label($model, 'rememberMe'); ?>
    <?php echo $form->error($model, 'rememberMe'); ?>
  </div>

  <div class="row buttons">
    <?php echo CHtml::submitButton(Yii::t('app', 'Form.login')); ?>
  </div>

  <?php $this->endWidget(); ?>
</div>
