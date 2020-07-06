namespace App
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.tbLog = new System.Windows.Forms.TextBox();
            this.spnX = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.spnY = new System.Windows.Forms.NumericUpDown();
            this.tmrRelease = new System.Windows.Forms.Timer(this.components);
            this.btnSend = new System.Windows.Forms.Button();
            this.cbLeft = new System.Windows.Forms.CheckBox();
            this.cbMiddle = new System.Windows.Forms.CheckBox();
            this.cbRight = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.spnX)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnY)).BeginInit();
            this.SuspendLayout();
            // 
            // tbLog
            // 
            this.tbLog.Location = new System.Drawing.Point(12, 12);
            this.tbLog.Multiline = true;
            this.tbLog.Name = "tbLog";
            this.tbLog.Size = new System.Drawing.Size(528, 202);
            this.tbLog.TabIndex = 0;
            this.tbLog.Text = "Enter relative desktop [X,Y] coords [-10, -10] is upper left, [10, 10] is lower r" +
    "ight and the press the Send button.";
            // 
            // spnX
            // 
            this.spnX.Location = new System.Drawing.Point(49, 234);
            this.spnX.Maximum = new decimal(new int[] {
            127,
            0,
            0,
            0});
            this.spnX.Minimum = new decimal(new int[] {
            127,
            0,
            0,
            -2147483648});
            this.spnX.Name = "spnX";
            this.spnX.Size = new System.Drawing.Size(87, 22);
            this.spnX.TabIndex = 1;
            this.spnX.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(26, 236);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(17, 17);
            this.label1.TabIndex = 2;
            this.label1.Text = "X";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(166, 236);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(17, 17);
            this.label2.TabIndex = 4;
            this.label2.Text = "Y";
            // 
            // spnY
            // 
            this.spnY.Location = new System.Drawing.Point(189, 234);
            this.spnY.Maximum = new decimal(new int[] {
            127,
            0,
            0,
            0});
            this.spnY.Minimum = new decimal(new int[] {
            127,
            0,
            0,
            -2147483648});
            this.spnY.Name = "spnY";
            this.spnY.Size = new System.Drawing.Size(87, 22);
            this.spnY.TabIndex = 3;
            this.spnY.Value = new decimal(new int[] {
            10,
            0,
            0,
            0});
            // 
            // tmrRelease
            // 
            this.tmrRelease.Interval = 1000;
            this.tmrRelease.Tick += new System.EventHandler(this.tmrRelease_Tick);
            // 
            // btnSend
            // 
            this.btnSend.Location = new System.Drawing.Point(296, 234);
            this.btnSend.Name = "btnSend";
            this.btnSend.Size = new System.Drawing.Size(244, 23);
            this.btnSend.TabIndex = 5;
            this.btnSend.Text = "Send to Mouse Rel Driver";
            this.btnSend.UseVisualStyleBackColor = true;
            this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
            // 
            // cbLeft
            // 
            this.cbLeft.AutoSize = true;
            this.cbLeft.Location = new System.Drawing.Point(29, 279);
            this.cbLeft.Name = "cbLeft";
            this.cbLeft.Size = new System.Drawing.Size(54, 21);
            this.cbLeft.TabIndex = 6;
            this.cbLeft.Text = "Left";
            this.cbLeft.UseVisualStyleBackColor = true;
            // 
            // cbMiddle
            // 
            this.cbMiddle.AutoSize = true;
            this.cbMiddle.Location = new System.Drawing.Point(104, 279);
            this.cbMiddle.Name = "cbMiddle";
            this.cbMiddle.Size = new System.Drawing.Size(71, 21);
            this.cbMiddle.TabIndex = 7;
            this.cbMiddle.Text = "Middle";
            this.cbMiddle.UseVisualStyleBackColor = true;
            // 
            // cbRight
            // 
            this.cbRight.AutoSize = true;
            this.cbRight.Location = new System.Drawing.Point(189, 279);
            this.cbRight.Name = "cbRight";
            this.cbRight.Size = new System.Drawing.Size(63, 21);
            this.cbRight.TabIndex = 8;
            this.cbRight.Text = "Right";
            this.cbRight.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(552, 323);
            this.Controls.Add(this.cbRight);
            this.Controls.Add(this.cbMiddle);
            this.Controls.Add(this.cbLeft);
            this.Controls.Add(this.btnSend);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.spnY);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.spnX);
            this.Controls.Add(this.tbLog);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Tetherscript Virtual Mouse Driver Rel Sender";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Shown += new System.EventHandler(this.Form1_Shown);
            ((System.ComponentModel.ISupportInitialize)(this.spnX)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.spnY)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tbLog;
        private System.Windows.Forms.NumericUpDown spnX;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.NumericUpDown spnY;
        private System.Windows.Forms.Timer tmrRelease;
        private System.Windows.Forms.Button btnSend;
        private System.Windows.Forms.CheckBox cbLeft;
        private System.Windows.Forms.CheckBox cbMiddle;
        private System.Windows.Forms.CheckBox cbRight;
    }
}

